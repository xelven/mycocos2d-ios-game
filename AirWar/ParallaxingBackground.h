//
//  ParallaxingBackground.h
//  FlyWar
//
//  Created by Allen Chan on 26/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "CCSprite.h"

@interface ParallaxingBackground : CCSprite
{
    NSMutableArray *positions;
    NSMutableArray *buffers;
    
    /// The speed which the background is moving
    int speed;
    float speedTime;
}

- (id) initWithSpeed:(NSString*)_texturePath:(int)_screenWidth:(int)_speed:(float)_speedTime;

- (void) startup;
- (void) update;

//- (void) Draw;

@end
