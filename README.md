# TimerService
This module provides a better control of the time than task.wait()/wait(). Just because you are able to control it

# Functions and constructors

To make a new timer you can use this part of the code :<br>
```lua
  TimerService = require(PathToModule)
  Timer = TimerService.new(Start,End,Add) -- Start and end is number while Add determinates is it going to add or subtract (true is add and false is subtract)
```

Simple as that. Now let's start it and check is it really counting:<br>

```lua
  TimerService = require(PathToModule)
  Timer = TimerService.new(0,5,true)
  
  Timer:Start()
  Timer.Completed:Wait()
  print("I'm done counting!")
```

Those parts of the code should have explained how does this module work.<br>
Now let's get to a small documentation I wrote just to give you a better understanding<br>

**Constructors** <br>
Methods: <br>

   new - this function has 3 arguments (Start,End,Add). It creates a new Timer <br>
   
   Arguments:<br>
      Start - a starting number to count from<br>
      End - an end number which will end counting on<br>
      Add - true or false statement where true stands for add and false for subtract<br>
  
**Timer**
Proporties:<br>

Time - Current time of the timer<br>
   Completed - RBXScriptSignal, fires when Timer done counting<br>
   Began - RBXScriptSignal, fires when Timer began counting<br>
   
Methods:<br>
   Start() - Starts Timer and fires Began event<br>
   Stop() - Resets Timer, does not fire Completed event<br>
   Pause() - Pauses Timer, does not fire Completed event<br>
