//
//  Explosion.h
//  AirWar
//
//  Created by Allen Chan on 29/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "CCSprite.h"
@class Animation;

@interface Explosion : CCSprite
{
    id action;
}

@property (nonatomic, retain)Animation* explosAnimation;
@property BOOL Active;


- (id)initWithPosition:(Animation*) _exAnimation:(CGPoint) _point;

- (void)startup;
- (void)stoped;
- (void)finished;

@end
