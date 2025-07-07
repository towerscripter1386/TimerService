--[[
Copyright 2025 Arsenij Ivashenko

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
]]

--!strict
--!optimize 2

--Services
local RunService = game:GetService("RunService")

--Datatypes
local Heartbeat = RunService.Heartbeat

--Variables
local M_timer:TimerMeta

--Methods

--Creates a new timer, fields are optional and can be set later on in the object
local function Timer_new(End:number?,Add:boolean?) : Timer
	local BeganEvent = Instance.new("BindableEvent")
	local EndedEvent = Instance.new("BindableEvent")
	local PausedEvent = Instance.new("BindableEvent")
	
	local add:boolean
	local timeT = 0
	local endT = End or 1
	
	if type(Add) == "nil" then
		add = true
	else
		add = Add
		if not add then
			timeT = End or 1
			endT = 0
		end
	end
	
	return setmetatable(
		{
			_add = add;
			_time = timeT;
			_end = endT;
			
			_event = nil::any;
			
			_began = BeganEvent;
			_ended = EndedEvent;
			_paused = PausedEvent;
			
			Began = BeganEvent.Event::RBXScriptSignal;
			Ended = EndedEvent.Event::RBXScriptSignal;
			Paused = PausedEvent.Event::RBXScriptSignal;
		},
		M_timer
	)
end

--Destroys the timer, this is the proper way to dispose of the Timer object
local function Timer_Destroy(self:TimerObj) : ()
	local event = self._event
	if event then
		event:Disconnect()
	end
	
	self._began:Destroy()
	self._ended:Destroy()
	self._paused:Destroy()
	
	table.clear(self::any)
end

--Resets the countdown
local function Timer_Reset(self:TimerObj) : ()
	if self._add then
		self._time = 0
	else
		self._time = self._end
	end
end

--Starts the countdown
local function Timer_Start(self:TimerObj) : ()
	local t = self._time
	
	if self._add then
		if t == self._end then
			self._time = 0
		end
	else
		if t == 0 then
			self._time = self._end
		end
	end
	
	
	self._began:Fire(self._time)
	
	self._event = Heartbeat:Connect(function(dt)
		local t = self._time
		
		if self._add then
			local endT = self._end
			t += dt
			if t >= endT then
				self._time = endT
				self._ended:Fire(endT); -- it won't compile if you don't add ;
				(self::any)._event:Disconnect()
				self._event = nil
				return -- return in case of the game running in deferred mode
			end
		else
			t -= dt
			if t <= 0 then
				self._time = 0
				self._ended:Fire(0);
				(self::any)._event:Disconnect()
				self._event = nil
				return
			end
		end
		
		self._time = t
	end)
end

--Pauses the countdown, does not fire Ended
local function Timer_Pause(self:TimerObj) : ()
	local event = self._event
	if event then
		event:Disconnect()
		self._event = nil
	end

	self._paused:Fire(self._time)
end

--Stops the countdown, does not fire Ended
local function Timer_Stop(self:TimerObj) : ()
	Timer_Reset(self)
	Timer_Pause(self)
end

--Types 
export type TimerMeta = {
	read __index:TimerMeta;
	
	read new:typeof(Timer_new);
	read Destroy:typeof(Timer_Destroy);
	read Start:typeof(Timer_Start);
	read Stop:typeof(Timer_Stop);
	read Pause:typeof(Timer_Pause);
	read Reset:typeof(Timer_Reset);
}

export type TimerObj = {
	_add:boolean;
	_time:number;
	_end:number;
	
	_event:RBXScriptConnection?;
	
	_began:BindableEvent;
	_ended:BindableEvent;
	_paused:BindableEvent;
	
	Began:RBXScriptSignal;
	Ended:RBXScriptSignal;
	Paused:RBXScriptSignal;
}

export type Timer = setmetatable<TimerObj,TimerMeta>

--Tables
M_timer = {
	new = Timer_new;
	
	Destroy = Timer_Destroy;
	Start = Timer_Start;
	Stop = Timer_Stop;
	Pause = Timer_Pause;
	Reset = Timer_Reset;
}
M_timer.__index = M_timer
table.freeze(M_timer) -- make it static

return Timer_new()
