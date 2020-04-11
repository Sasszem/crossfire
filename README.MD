[![CircleCI](https://circleci.com/gh/Sasszem/crossfire.svg?style=svg)](https://circleci.com/gh/Sasszem/crossfire)
# Crossfire

### Introduction
My goal is to create a game similat to [Crossfire](https://seet.itch.io/crossfire), a bullett-dodging shooting-less shooter for windows.
The original game was featured in [The Best Games from GMTK Game Jam 2018](https://www.youtube.com/watch?v=s2ebZXQ_J8Q).

### Why so much code & complexity?
My secondary goal is to let this project be kind of enterprise-ready
- I have some unit tests
- I plan to make good documentation
- I designed the backbone of the game to be extensible
- (said backbone might be possible to refactor into its own framework in the future)
- Refactored, re-implemented most of it
- Went trough multiple OOP -> Functional -> OOP paradigm shifts
- I track all of the work through github, using issues heavily
So overall I created a few (hopefully) real-life-like issues for myself to deal with, just so I can try dealing with them.
If my productivity suffered in the process, that only means I learnt a few things.

### So is this game playable & fun?
Currently, not so much, and I struggle to improve on it.
I feel like I'm not that good of a game designer, but I'll try to do my best to make this fun.

### Technical overview
 - [LÖVE2D](https://love2d.org/) engine
 - [Moonscript](https://moonscript.org/)
 - [Nata](https://github.com/tesselode/nata/) [ECS](https://en.wikipedia.org/wiki/Entity_component_system)-lib

### If you'd want to try it out...
I do not underestand why would you want, but sure
You only need Löve2D, version 11.3 to run this, and a precompiled bundle, wihch I currently do not have.

#### To make that bundle yourself
You need:
 - Lua 5.3
 - luarocks
 - a linux system
Steps:
- run `luarocks install moonscript`
- clone this repository & cd into it
- run `moon build.moon package`
- your bundle is in the project directory, named `game.love`


### Thanks to
 - the LÖVE2D team for this engine
 - Leafo for Moonscript
 - Tesselode for Nata
 - David Chung for the font I'm using
 
