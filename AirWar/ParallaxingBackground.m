//
//  ParallaxingBackground.m
//  FlyWar
//
//  Created by Allen Chan on 26/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "ParallaxingBackground.h"
#import "cocos2d.h"

@implementation ParallaxingBackground


- (id) initWithSpeed:(NSString*)_texturePath:(int)_screenWidth:(int)_speed:(float)_speedTime;
{
    self = [super initWithFile:_texturePath];
    if(self){
        speed = _speed;
        speedTime = _speedTime;
/*        
        //m_background = [CCSprite spriteWithSpriteFrameName:@"mainbackground.png"];
        buffer1 = [[CCSprite alloc]initWithTexture:texture_];
        [buffer1 setAnchorPoint:CGPointMake(0,0)];
        [buffer1 setPosition:CGPointMake(0, 0)];
        
        buffer2 = [[CCSprite alloc]initWithTexture:texture_];
        [buffer2 setAnchorPoint:CGPointMake(0,0)];
        [buffer2 setPosition:CGPointMake(0, 0)];    
        
        [self addChild:buffer1 z:0 tag:0];
        [self addChild:buffer2 z:1 tag:1];
*/        
        //NSMutableArray *array = [[NSMutableArray alloc] init];
        
        positions =[[NSMutableArray alloc] init];
        int arrayLength = _screenWidth/self.texture.contentSize.width+1;
        for(int i=0;i<arrayLength;++i)
        {
            [positions addObject:NSStringFromCGPoint(CGPointMake(i*self.texture.contentSize.width, 0))];
            //CGPointMake(i*texture.size.width, 0)];
        }
        //positions = array;
        
        buffers = [[NSMutableArray alloc] init];
        for(int i=0;i<arrayLength;++i)
        {
            CCSprite *_buffer = [[CCSprite alloc]initWithTexture:texture_];
            [_buffer setAnchorPoint:CGPointMake(0,0)];
            [_buffer setPosition:CGPointMake(0,0)];
            [buffers addObject:_buffer];
            [self addChild:_buffer z:i tag:i];
        }
        [self setAnchorPoint:CGPointMake(0, 0)];
        
    }
    return self;
}
- (void) startup
{
    [self schedule:@selector(update) interval:speedTime];
}
- (void) update
{
    // Update the positions of the background
    for (int i = 0; i < [positions count]; i++)
    {
        
        CGPoint _position = CGPointFromString([positions objectAtIndex:i]);
        // Update the position of the screen by adding the speed
        _position.x += speed;
        // If the speed has the background moving to the left
        if (speed <= 0)
        {
            // Check the texture is out of view then put that texture at the end of the screen
            if (_position.x <= -self.texture.contentSize.width)
            {
                _position.x = self.texture.contentSize.width * ([positions count] - 1);
            }
        }
        
        
        // If the speed has the background moving to the right
        else
        {
            // Check if the texture is out of view then position it to the start of the screen
            if (_position.x >= self.texture.contentSize.width * ([positions count] - 1))
            {
                _position.x = -self.texture.contentSize.width;
            }
        }
        
        //NSMutableArray *array = positions;
        [positions replaceObjectAtIndex:i withObject:NSStringFromCGPoint(_position)];
        CCSprite *_buffer = [buffers objectAtIndex:i];
        [_buffer setPosition:_position];
    }
}
/*
-(void) draw
{
    if(self.texture)
        for (int i = 0; i < [positions count]; i++)
        {
            CGPoint _position = CGPointFromString([positions objectAtIndex:i]);
            //[self setPosition:_position];
            [self.texture drawAtPoint:_position];
        }
}
*/
/*
- (void) Initialize:(NSString*)texturePath:(int)_screenWidth:(int)_speed
{
    texture = [UIImage imageNamed:texturePath];
    speed = _speed;
    
    //positions = [NSArray alloc];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    
    int arrayLength = _screenWidth/texture.size.width+1;
    
    for(int i=0;i<arrayLength;++i)
    {
        [array addObject:NSStringFromCGPoint(CGPointMake(i*texture.size.width, 0))];
         //CGPointMake(i*texture.size.width, 0)];
    }
    positions = array;
}

- (void) update:(double)gameTime
{
    // Update the positions of the background
    for (int i = 0; i < [positions count]; i++)
    {
        
        CGPoint _position = CGPointFromString([positions objectAtIndex:i]);
        // Update the position of the screen by adding the speed
        _position.x += speed;
        // If the speed has the background moving to the left
        if (speed <= 0)
        {
            // Check the texture is out of view then put that texture at the end of the screen
            if (_position.x <= -texture.size.width)
            {
                _position.x = texture.size.width * ([positions count] - 1);
            }
        }
        
        
        // If the speed has the background moving to the right
        else
        {
            // Check if the texture is out of view then position it to the start of the screen
            if (_position.x >= texture.size.width * ([positions count] - 1))
            {
                _position.x = -texture.size.width;
            }
        }
        
        //NSMutableArray *array = positions;
        [positions replaceObjectAtIndex:i withObject:NSStringFromCGPoint(_position)];
    }
}

- (void) Draw
{
    if(texture)
        for (int i = 0; i < [positions count]; i++)
        {
            CGPoint _position = CGPointFromString([positions objectAtIndex:i]);
            [texture drawAtPoint:_position];
        }
}
 */

@end
