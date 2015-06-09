//
//  Boat.h
//  AirWar
//
//  Created by Allen Chan on 27/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "CCSprite.h"

@class Animation;

@interface Boat : CCSprite
{
    id action;
}

@property (nonatomic, retain)Animation* playerAnimation;
@property BOOL Active;
//@property CGPoint position;
@property int health;


- (int) getWidth;
- (int) getHeight;

- (id)Initialize:(Animation*)_PlayerAnimation :(CGPoint) thePosition;

- (void)startup;
- (void)stoped;
/*
- (void)Update:(double)gameTime;
- (void)Draw;
*/

@end
