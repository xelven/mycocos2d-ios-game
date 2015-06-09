//
//  Boat.m
//  AirWar
//
//  Created by Allen Chan on 27/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "Boat.h"
#import "Animation.h"

@implementation Boat
@synthesize Active = _Active;
@synthesize health = _health;
//@synthesize position = _position;
@synthesize playerAnimation = _playerAnimation;


- (int) getWidth
{
    if(self.playerAnimation)
        return self.playerAnimation.FrameWidth;
    return -1;
}
- (int) getHeight
{
    if(self.playerAnimation)
        return self.playerAnimation.FrameHeight;
    return -1;
}

- (id)Initialize:(Animation*)_PlayerAnimation :(CGPoint) thePosition
{
    self = [super init];
    if(self){
        self.playerAnimation = _PlayerAnimation;
        self.health = 100;
        self.Active = YES;
        [self setAnchorPoint:CGPointMake(0, 0)];
        [self setPosition:thePosition];
    }
    return self;
}

- (void)startup
{
    action = [self.playerAnimation getAction];
    [self runAction:action];
}
- (void)stoped
{
    [self stopAction:action];
}

@end
