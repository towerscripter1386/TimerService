 -[[  Copyright 2023 Arsenij Ivashenko

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
]
local CompletedEvent = Instance.new("BindableEvent")
local BeganEvent = Instance.new("BindableEvent")

local module = {new = function(Start:number,End:number,Add:boolean)
	local Timer = {Time = Start,Completed = CompletedEvent.Event,Began = BeganEvent.Event}
	local Run
	function Timer:Start()
		if Add then
			if Timer.Time > End or Timer.Time < Start then return end
		else
			if Timer.Time < End or Timer.Time > Start then return end
		end
		BeganEvent:Fire()
		Run = game:GetService("RunService").Heartbeat:Connect(function(DeltaTime)
			if Add then
				Timer.Time += DeltaTime
				if Timer.Time > End then
					CompletedEvent:Fire()
					Timer:Pause()
				end
			else
				Timer.Time -= DeltaTime
				if Timer.Time < End then
					CompletedEvent:Fire()
					Timer:Pause()
				end
			end
		end)
	end	
	function Timer:Pause()
		if Run then
			Run:Disconnect()
		end
	end	
	function Timer:Stop()
		if Run then
			Run:Disconnect()
		end
		Timer.Time = Start
	end	
	return Timer
end}

return module
