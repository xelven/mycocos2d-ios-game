//
//  HelloWorldLayer.h
//  AirWar
//
//  Created by Allen Chan on 27/06/2012.
//  Copyright Allen Chan 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class ParallaxingBackground;
@class Animation;
@class Boat;
@class Enemy;
@class Projectile;

@interface AirWorldLayer : CCLayer
{
    Boat* boat;
    float playerMoveSpeed;
    //UIImage* mainBackground;
    CCSprite* mainBackground;
    ParallaxingBackground* bgLayer1;
    ParallaxingBackground* bgLayer2;
    Animation *enemyAnimation;
    
    int pointx;
    int pointy;
    
    float spawnTime;
    
    NSMutableArray *enemys;
    //Enemy *enemy;
    // The rate at which the enemies appear
    float enemySpawnTime;
    float previousSpawnTime;
    
    // A random number generator
    float random;
    
    //
    NSMutableArray *projectiles;
    //Projectile* projectile;
    NSString * laserString;
    
    // The rate of fire of the player laser
    float fireTime;
    float previousFireTime;
    
    CGPoint laserPointion;
    
    Animation* explosionAnimation;
    NSMutableArray* explosions;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

- (void) startup;
- (void) updateSelf;

//- (void) InitializeSelf;
- (void) LoadContent;
- (void) UnloadContent;

//
- (void)updateCollision;


//projectiles
- (void) addProjectile:(CGPoint)_position;
- (void) UpdateProjectiles;
- (void) shoot;


//enemy's operate
- (void) addEnemy;
- (void)updateEnemy;


//explosion show up
- (void) addExplosion:(CGPoint)_point;
- (void) updateExplosion;

@end
