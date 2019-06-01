# Crossfire

## Introduction
My goal is to recreate the game [Crossfire](https://seet.itch.io/crossfire), a bullett-dodging shooting-less shooter for windows.
The original game was featured in [The Best Games from GMTK Game Jam 2018](https://www.youtube.com/watch?v=s2ebZXQ_J8Q).

### Gameplay overview

***

#### Playfield
 - A rectangular area with walls

#### Player
 - Controlled via the mouse or by touch
 - Follows the mouse with a constant speed. 
 - The position/direction is only sampled once in a while - so the player reacts a bit slowly
 - Can have [Powerups](#powerups)
 - Has [Shield](#shield)
 
#### Camera
 - Always focused on the [Player](#Player)
 - The player is always on the center of the screen

#### Enemies
 - Spawn on the playfield, near the [Player](#player) randomly
 - Destroyed by bullets, and drop [Orbs](#orbs) on their death
 - Enemy count is dependant of the players current [Score](#score)
 - Aim and shoot [Bullets](#Bullet) at the player
 - Try to keep a somewhat constant distance to the player (with upper & lower distance treshold)
 - Only shoot if they are in that distance treshold
 - Have a cooldown timer on shooting, indicated by their colors

##### Big Enemies
 - Spawn later in the game
 - Shoots [Exploding bullets](#exploding-bullets)
  
#### Bullets
 - Bullets kill the [Player](#player), as well as all types of [Enemies](#enemies)

##### Exploding Bullets
 - Kill the player or the enemies
 - Deal areof of damage (kill in a radius of impact)
 
#### Orbs
 - Dropped by [Enemies](#enemies)
 - Add to the players [Score](#score)
 
#### Powerups
##### Ghost
 - Makes the [Player](#Player) invurnable to [Bullets](#bullets), as they pass trugh him
##### Deflector
 - Makes [Bullets](#bullets) turn around and (possibly) hit the [Enemies](#enemies) 
##### Buster
 - Speeds up the [Player](#Player)
 - The player can kill [Enemies](#enemies) by running into them
 
### Shield
 - Makes the [Player](#Player) withstand a single hit by a [Bullet](#bullets)
 - Breaks on hit
 - On break, releases an explosion, killing all [Enemies](#enemies)
 - Recharges via the [Score](#score)
 
### Score
 - Increases by collecting [Orbs](#orbs)
 - Recharges [Shield](#shield)
 - Highscore is saved
 