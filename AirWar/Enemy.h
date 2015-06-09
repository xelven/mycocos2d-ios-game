//
//  Enemy.h
//  AirWar
//
//  Created by Allen Chan on 28/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "CCSprite.h"

@class Animation;

@interface Enemy : CCSprite
{
    id action;
@private
    //the speed at which the enemy moves
    float enemyMoveSpeed;
    
}

//Animation repesesnting the enemy
@property (nonatomic,retain)Animation* enemyAnimation;
/*
//the position of the enemy ship relative to the top left corner of thescreen
//@property CGPoint position;
*/

// the state of the Enemy ship
@property BOOL Active;

// the hit points of the enemy, if this goes to zero the enemy dies
@property int health;

//the amount of damage the enemy inflicts on the player ship
@property int damage;

//the amount of score the enemy will give to the player
@property int value;

- (id)Initialize:(Animation*)_enemyAnimation :(CGPoint) thePosition;

- (int) getWidth;
- (int) getHeight;

- (void)startup;
- (void)stoped;

- (void) update;
- (void) updateWithPosition:(CGPoint) _position;

@end
