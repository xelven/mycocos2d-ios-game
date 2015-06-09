//
//  Projectile.m
//  AirWar
//
//  Created by Allen Chan on 28/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "Projectile.h"
#import "CCTextureCache.h"

@implementation Projectile
@synthesize Active;
@synthesize damage;

-(id)InitializeWithViewport:(CGRect)_viewport:(NSString*) _texturePath: (CGPoint)_position
{
    CCTexture2D* _text = [[CCTextureCache sharedTextureCache]textureForKey:@"Content/laser.png"];
    self = [super initWithTexture:_text];
    if(self)
    {
        viewport = _viewport;
        [self setAnchorPoint:CGPointMake(0, 0)];
        [self setPosition:_position];
        
        Active = YES;
        
        damage = 2;
        
        projectileMoveSpeed = 20.0f;
    }
    return self;
}


// Get the width of the projectile ship
- (int) getWidth
{
    if(self.texture)
        return self.texture.contentSize.width;
    return -1;
}


// Get the height of the projectile ship
- (int) getHeight
{
    if(self.texture)
        return self.texture.contentSize.height;
    return -1;
}

- (void) update
{
    /*
     // Projectiles always move to the right
     Position.X += projectileMoveSpeed;
     
     // Deactivate the bullet if it goes out of screen
     if (Position.X + Texture.Width / 2 > viewport.Width)
     Active = false;
     */
    CGPoint _point = self.position;
    _point.x +=projectileMoveSpeed;
    [self setPosition:_point];
    
    if(_point.x + self.texture.contentSize.width/2 > viewport.size.width)
        Active = NO;
    
}

@end
