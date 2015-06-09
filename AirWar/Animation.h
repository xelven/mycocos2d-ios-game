//
//  Animation.h
//  FlyWar
//
//  Created by Allen Chan on 25/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Animation : NSObject{
    /*
    NSMutableArray *images;
    UIImage* currentImage;
    
    // The image representing the collection of images used for animation
    UIImage* spriteStrip;
    */
    
    
    NSString* textureName;
    // The scale used to display the sprite strip
    float scale;
    
    // The time since we last updated the frame
    double elapsedTime;
    
    // The time we display a frame until the next one
    int frameTime;
    
    // The number of frames that the animation contains
    int frameCount;
    
    // The index of the current frame we are displaying
    int currentFrame;
    
    // The color of the frame we will be displaying
    UIColor *color;
    
    // The area of the image strip we want to display
    //Rectangle sourceRect = new Rectangle();
    CGRect sourceRect;
    
    // The area where we want to display the image strip in the game
    //Rectangle destinationRect = new Rectangle();
    CGRect destinationRect;
     
     
    /*
    
    // Width of a given frame
    int FrameWidth;
    
    // Height of a given frame
    int FrameHeight;
    
    // The state of the Animation
    BOOL Active;
    
    // Determines if the animation will keep playing or deactivate after one run
    BOOL Looping;
    
    // Width of a given frame
    //Vector2 Position;
    CGPoint position;
    */
}

/*
@property (retain,readwrite) UIColor *color;

// The area of the image strip we want to display
//Rectangle sourceRect = new Rectangle();
@property CGRect sourceRect;

// The area where we want to display the image strip in the game
//Rectangle destinationRect = new Rectangle();
@property CGRect destinationRect;

@property (copy,readwrite)NSString* textureName;
// The scale used to display the sprite strip
@property float scale;

// The time since we last updated the frame
@property double elapsedTime;

// The time we display a frame until the next one
@property int frameTime;

// The number of frames that the animation contains
@property int frameCount;

// The index of the current frame we are displaying
@property int currentFrame;
*/

@property int FrameWidth;
@property int FrameHeight;
@property BOOL Active;
@property BOOL Looping;
@property CGPoint position;

//int frameWidth, int frameHeight, int frameCount,
//int frametime, Color color, float scale, bool looping)
- (void)Initialize:(NSString*)_texturePath :(NSString*)_textureName:(CGPoint) thePosition:(int) _frameWidth:(int) _frameHeight:(int) _frameCount:(int) _frametime:(UIColor*)_color: (float)_scale : (BOOL)_looping;

- (id)getAction;
- (void)unload;
/*
- (void)Update:(double)gameTime;
- (void)Draw;
*/

@end
