# ⏱️ TimerService

A lightweight and efficient countdown/count-up timer module for Roblox, written in Luau. It supports starting, pausing, resetting, and stopping timers with event-driven notifications.

---

## 🚀 Features

- Count **up** or **down** from a specified time
- Event-driven: `Began`, `Paused`, `Ended` signals
- Optimized and strict-typed using Luau
- Clean lifecycle management with `Destroy`

---

## 📦 Installation

Add `TimerService` as a ModuleScript in **ReplicatedStorage** or any preferred location in your Roblox game.

```luau
local TimerService = require(path.to.TimerService)
```

---

## 🛠️ Usage

### 🔹 Creating a Timer

```luau
local timer = TimerService.new(5, true) -- 5 seconds, counting up
```

**Parameters:**
- `End: number?` – Target time in seconds (default: 1)
- `Add: boolean?` – If true, timer counts **up** to `End`. If false, counts **down** (default: true)

---

### 🔹 Starting the Timer

```luau
timer:Start()
```

---

### 🔹 Pausing the Timer

```lua
timer:Pause()
```

---

### 🔹 Stopping (Reset + Pause)

```luau
timer:Stop()
```

---

### 🔹 Resetting Time

```luau
timer:Reset()
```

---

### 🔹 Destroying the Timer

```luau
timer:Destroy()
```

---

## 📡 Events

Timers are event-driven and expose these signals:

| Event   | Description                            |
|---------|----------------------------------------|
| `Began` | Fired when the timer starts            |
| `Ended` | Fired when the timer completes         |
| `Paused`| Fired when the timer is paused         |

```luau
timer.Began:Connect(function(startTime)
	print("Timer began at:", startTime)
end)

timer.Ended:Connect(function()
	print("Timer ended!")
end)

timer.Paused:Connect(function(currentTime)
	print("Timer paused at:", currentTime)
end)
```

---

## 🔧 API

### `TimerService.new(endTime: number?, add: boolean?) → Timer`
Creates a new Timer instance.

### `Timer:Start()`
Starts the countdown/count-up.

### `Timer:Pause()`
Pauses the timer (retains state).

### `Timer:Stop()`
Stops and resets the timer.

### `Timer:Reset()`
Resets the timer to its initial state.

### `Timer:Destroy()`
Cleans up events and memory (use before discarding the timer).

---

## 🧱 Type Definitions

```luau
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
```

<hr>

used chatgpt to generate the README, it should be accurate enough for you to understand it properly
