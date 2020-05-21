# Crossfire

### Introduction
My goal is to create a game similar to [Crossfire](https://seet.itch.io/crossfire), a bullett-dodging shooting-less shooter for windows.
The original game was featured in [The Best Games from GMTK Game Jam 2018](https://www.youtube.com/watch?v=s2ebZXQ_J8Q).

### How to play
This is a bullet-dodging game. You control your character via the mouse, hopefully in a way to avoid being shot by the enemies. The enemies spawn randomly, and try to shoot you. You can not shoot back, instead you should try letting them shoot each other. When an enemy dies, you can get some points by collecting the orbs it left. Be quick, as the do despawn.
Sometimes you get some powerups, such as shield (bullets bounce back), ghost(bullets pass trough you) or buster(you get faster, smaller and you can punch trought enemies) (not implemented yet). After some points, a few bigger enemies will spawn that shoot exploding bullets, which may kill more than one enemies...
When you die, you spawn a shockwave that kills everything. When you run out of your lives (3), it is game over (not implemented yet).
Press the mouse to enter slow-mo mode, where the game slows down by 5

#### Keyboard shortcuts in debug mode
- D to toggle debug draw
- RETURN to freeze game
- S to step 0.1s, SPACE to step 0.001s (only while frozen)
- W to spawn a shockwave
- Press 1 to spawn an enemy at the cursor
- Press 2 to spawn a big enemy at the cursor
- Press x to delete entity under cursor

### Why so much code & complexity?
My secondary goal is to let this project be kind of enterprise-ready
- I have some unit tests (currently disabled)
- I plan to make good documentation
- Refactored, re-implemented most of it many-many times
- Went trough multiple OOP -> Functional -> OOP paradigm shifts
- I track all of the work through github, using issues heavily

So overall I created a few (hopefully) real-life-like issues for myself to deal with, just so I can try dealing with them. This was partly unintentional...
If my productivity suffered in the process, that only means I learnt a few things.

### So is this game playable & fun?
Currently, not so much, and I struggle to improve on it.
I feel like I'm not that good of a game designer, but I'll try to do my best to make this fun.

### Technical overview
 - [LÖVE2D](https://love2d.org/) engine
 - [Nata](https://github.com/tesselode/nata/) [ECS](https://en.wikipedia.org/wiki/Entity_component_system)-lib
 - [flux tweening lib](https://github.com/rxi/flux)
 - [my own GUI lib](https://github.com/sassszem/yalg)

### If you'd want to try it out...
I do not underestand why would you want, but sure
You only need Löve2D, version 11.3 to run this, and a precompiled bundle from the [releases page](https://github.com/Sasszem/crossfire/releases)

#### To make that bundle yourself
You need:
 - Lua 5.3
 - luarocks
 - a linux system
 - libzip
Steps:
- clone this repo and `cd` into it
- run `lua build.lua install-dev`
This'll install `love-release` and also `luacheck`
- run `lua build.lua package`
- your files are in the releases directory

To simply play the game:
- `lua build.lua launch`

To check for linting erros:
- `lua build.lua lint`

To clean up your mess:
- `lua build.lua clean`

### Used assets
- [David Chung's DigitFont](https://www.1001fonts.com/01-digit-font.html)
- [Some bell sound from orangefreesounds.com](http://www.orangefreesounds.com/ding-ding-ding/) (edited that a bit)
- [supercomputer font by Disaster Fonts](https://www.1001fonts.com/supercomputer-font.html)
- [Firecraker sound for shooting](http://www.orangefreesounds.com/firecracker-sounds/) - edited that heavily 
- [Explosion sound](http://www.orangefreesounds.com/8-bit-explosion/)
- [powerup sound](http://www.orangefreesounds.com/video-game-bonus-bell-sound-effect/)
- [extra life sound](http://www.orangefreesounds.com/video-game-bonus-bell-sound-effect/)
- [death sound](http://www.orangefreesounds.com/free-explosion-sound-effect/)- [bullet hit and menu](http://www.orangefreesounds.com/single-hammer-hit-on-wood/)
- [powerup reverse](http://www.orangefreesounds.com/shut-down-sound-effect/)
- [enemy spawning noises](http://www.orangefreesounds.com/vanishing-sound-effect/)
- [menu music](http://www.orangefreesounds.com/synth-bassline-124-bpm/)
- [game music](http://www.orangefreesounds.com/soft-lounge-background-track/)- [highscores music](http://www.orangefreesounds.com/groove-synth-loop-130-bpm/)

### Thanks to
 - the LÖVE2D team for this engine
 - Tesselode for Nata
 - RXI for flux
 - for the makers of the assets I used
