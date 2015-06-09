//
//  Animation.m
//  FlyWar
//
//  Created by Allen Chan on 25/06/2012.
//  Copyright (c) 2012 Allen Chan. All rights reserved.
//

#import "Animation.h"
#import "cocos2d.h"

@implementation Animation
@synthesize FrameWidth;
@synthesize FrameHeight;
@synthesize Active;
@synthesize Looping;
@synthesize position;
/*
@synthesize textureName;
@synthesize scale;
@synthesize sourceRect;
@synthesize color;
@synthesize currentFrame;
@synthesize elapsedTime;
@synthesize frameTime;
@synthesize frameCount;
@synthesize destinationRect;
*/
- (void)Initialize:(NSString*)_texturePath:(NSString*)_textureName:(CGPoint) thePosition:(int) _frameWidth:(int) _frameHeight:(int) _frameCount:(int) _frametime:(UIColor*)_color: (float)_scale : (BOOL)_looping;
{
//    spriteStrip = [UIImage imageNamed:texturePath];
    self.position = thePosition;
    
    self.FrameWidth = _frameWidth;
    self.FrameHeight = _frameHeight;
    frameCount = _frameCount;
    frameTime = _frametime;
    textureName = _textureName;
    
    UIImage*_temp = [UIImage imageNamed:_texturePath];
    CCTexture2D *_texture2d = [[CCTexture2D alloc]initWithCGImage:_temp.CGImage resolutionType:kCCResolutioniPhone];
    //加载人物的出拳资源到内存中，共8帧
    for (int i = 0; i < _frameCount; ++i)
    {
        sourceRect = CGRectMake(i * self.FrameWidth, 0, self.FrameWidth, self.FrameHeight);
        //虽然是2帧，但这两个资源是存在一张图片中的，因此读取的文件名相同，通过不同的rect剪裁、区分
        CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:_texture2d rect:sourceRect];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame:frame name:[NSString stringWithFormat:@"%@_%d",textureName,i]];
    }

    
/*    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(spriteStrip.CGImage, CGRectMake(0, 0, FrameWidth, FrameHeight));  
    currentImage = [UIImage imageWithCGImage:subImageRef];
*/    
    /*
     CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);  
     CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));  
     
     UIGraphicsBeginImageContext(smallBounds.size);  
     CGContextRef context = UIGraphicsGetCurrentContext();  
     CGContextDrawImage(context, smallBounds, subImageRef);  
     UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];  
     UIGraphicsEndImageContext();  
     
     return smallImage;  
     */
    
    color = _color;
    scale = _scale;
    Looping = _looping;
    
    
    // Set the time to zero
    elapsedTime = 0;
    currentFrame = 0;
    
    
    // Set the Animation to active by default
    self.Active = YES;
    
    /*
    images = [[NSMutableArray alloc]init];
    for(int i=0;i<frameCount;++i){
    //        sourceRect = new Rectangle(currentFrame * FrameWidth, 0, FrameWidth, FrameHeight);
    sourceRect = CGRectMake(i * FrameWidth, 0, FrameWidth, FrameHeight);
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(spriteStrip.CGImage, sourceRect);  
    [images addObject:[UIImage imageWithCGImage:subImageRef]];
    }
    */
}

- (id)getAction
{
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = 0; i < frameCount; ++i)
    {
        NSString* key = [NSString stringWithFormat:@"%@_%d",textureName, i];
        //从内存池中取出Frame
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
        //添加到序列中
        [array addObject:frame];
    }
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animBG = [CCAnimation animationWithFrames:array delay:0.1f];
    //生成动画播放的行为对象
    id selfact = [CCAnimate actionWithAnimation:animBG];
    id repeatAct;
    
    if(Looping == YES)
        repeatAct = [CCRepeatForever actionWithAction:selfact];
    else
        repeatAct = selfact;
    
    [array removeAllObjects];
    
    return repeatAct;
}

- (void)unload
{
    for (int i = 0; i < frameCount; ++i)
    {
        //虽然是2帧，但这两个资源是存在一张图片中的，因此读取的文件名相同，通过不同的rect剪裁、区分
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrameByName:[NSString stringWithFormat:@"%@_%d",textureName,i]];
    }
}

/*
- (void)Update:(double)gameTime
{
    if(Active != YES)
        return;
    
    elapsedTime+=gameTime*1000;
    
    if(elapsedTime > frameTime)
    {
        ++currentFrame;
        if (currentFrame == frameCount)
        {
            currentFrame = 0;
            // If we are not looping deactivate the animation
            if (Looping == NO)
                Active = NO;
        }
        


        currentImage = [images objectAtIndex:currentFrame];
        elapsedTime = 0;
    }
}
- (void)Draw
{
    if(currentImage)
        [currentImage drawAtPoint:position];
}
 */

@end
