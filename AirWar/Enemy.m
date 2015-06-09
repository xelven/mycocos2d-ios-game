//
//  Enemy.m
//  AirWar
//
//  Created by Allen Chan on 28/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "Enemy.h"
#import "Animation.h"

@implementation Enemy
@synthesize enemyAnimation;
@synthesize Active;
@synthesize damage;
@synthesize health;
@synthesize value;

- (id)Initialize:(Animation*)_enemyAnimation :(CGPoint) thePosition
{
    
    self = [super init];
    if(self){
        
        self.enemyAnimation = _enemyAnimation;
        
        // We initialize the enemy to be active so it will be update in the game
        self.Active = YES;
        
        // Set the health of the enemy
        self.health = 10;
        
        // Set the amount of damage the enemy can do
        self.damage = 10;
        
        // Set how fast the enemy moves
        enemyMoveSpeed = 3;
        
        // Set the score value of the enemy
        self.value = 100;
        
        [self setAnchorPoint:CGPointMake(0, 0)];
        [self setPosition:thePosition];
    }
    return self;
}

- (int) getWidth
{
    if(self.enemyAnimation)
        return self.enemyAnimation.FrameWidth;
    return -1;
}
- (int) getHeight
{
    if(self.enemyAnimation)
        return self.enemyAnimation.FrameHeight;
    return -1;
}

- (void)startup
{
    action = [self.enemyAnimation getAction];
    [self runAction:action];
}
- (void)stoped
{
    [self stopAction:action];
}

- (void) update
{
    CGPoint _point = self.position;
    _point.x -=enemyMoveSpeed;
    [self setPosition:_point];
    if (_point.x < - [self getWidth] || health <= 0)
    {
        // By setting the Active flag to false, the game will remove this objet fromthe 
        // active game list
        self.Active = NO;
    }
}
- (void) updateWithPosition:(CGPoint) _position
{
    CGPoint _point = self.position;
    
    int length = _point.x - _position.x;
    int speedMoving = length/enemyMoveSpeed;
    
    _point.x -=enemyMoveSpeed;
    
    
    if(_point.y > _position.y){
        int _length = _point.y - _position.y;
        _point.y -= _length/speedMoving;
        
    }else if(_position.y > _point.y){
        int _length = _position.y - _point.y;
        _point.y += _length/speedMoving;
    }
    
    [self setPosition:_point];
    if (_point.x < - [self getWidth] || health <= 0)
    {
        // By setting the Active flag to false, the game will remove this objet fromthe 
        // active game list
        self.Active = NO;
    }
}


@end
