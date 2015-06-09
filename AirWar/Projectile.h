//
//  Projectile.h
//  AirWar
//
//  Created by Allen Chan on 28/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "CCSprite.h"

@interface Projectile : CCSprite
{
    // State of the Projectile
 //   BOOL Active;
    
    // Represents the viewable boundary of the game
    CGRect viewport;
    
    float projectileMoveSpeed;
}
// State of the Projectile
@property BOOL Active;

// The amount of damage the projectile can inflict to an enemy
@property int damage;

-(id)InitializeWithViewport:(CGRect)_viewport:(NSString*) _texturePath: (CGPoint)_position;

// Get the width of the projectile ship
- (int) getWidth;


// Get the height of the projectile ship
- (int) getHeight;

- (void) update;

@end
