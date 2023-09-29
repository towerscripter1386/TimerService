# TimerService
This module provides a better control of the time than task.wait()/wait(). Just because you are able to control it

## Functions and constructors

To make a new timer, you can use this part of the code :
```lua
TimerService = require(PathToModule)
Timer = TimerService.new(Start,End,Add) -- Start and end are numbers, while Add determines whether it is going to add or subtract (true is add and false is subtract)
```

Simple as that. Now let's check if it's really counting:

```lua
TimerService = require(PathToModule)
Timer = TimerService.new(0,5,true)
  
Timer:Start()
Timer.Completed:Wait()
print("I'm done counting!")
```

Those parts of the code should have explained how this module works. 
Now let's get to the small documentation I wrote just to give you a better understanding
  
## Timer

### Constructors

- TimerService.new
   
### Arguments:
- Start - a starting number to count from
- End - an end number which will end counting on
- Add - true or false statement where true stands for add and false for subtract

### Proporties:<br>

- Time: Current time of the timer
- Completed - RBXScriptSignal, fires when Timer done counting
- Began - RBXScriptSignal, fires when Timer began counting
   
### Methods:
- Start() - Starts Timer and fires Began event
- Stop() - Resets Timer, does not fire Completed event
- Pause() - Pauses Timer, does not fire Completed event
