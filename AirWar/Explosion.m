//
//  Explosion.m
//  AirWar
//
//  Created by Allen Chan on 29/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "Explosion.h"
#import "Animation.h"
#import "cocos2d.h"

@implementation Explosion
@synthesize explosAnimation;
@synthesize Active;

- (id)initWithPosition:(Animation*) _exAnimation:(CGPoint) _point
{
    self = [super init];
    if(self)
    {
        [self setAnchorPoint:CGPointMake(0, 0)];
        self.explosAnimation = _exAnimation;
        self.Active = YES;
        [self setPosition:_point];
    }
    return self;
}

- (void)startup
{
    id _exAction = [self.explosAnimation getAction];
    id end = [CCCallFunc actionWithTarget:self selector:@selector(finished)];
    action = [CCSequence actions:_exAction,end, nil];
    [self runAction:action];
}
- (void)stoped
{
//    [self stopAction:action];
}

- (void)finished
{
    self.Active = NO;
//    [self stoped];
}
@end
