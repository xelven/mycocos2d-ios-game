//
//  HelloWorldLayer.m
//  AirWar
//
//  Created by Allen Chan on 27/06/2012.
//  Copyright Allen Chan 2012. All rights reserved.
//


// Import the interfaces
#import "AirWorldLayer.h"
#import "ParallaxingBackground.h"
#import "Animation.h"
#import "Boat.h"
#import "Enemy.h"
#import "Projectile.h"
#import "Explosion.h"

// HelloWorldLayer implementation
@implementation AirWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AirWorldLayer *layer = [AirWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
// init your code, todo.
//        [self InitializeSelf];
        [self LoadContent];
        [self addChild:mainBackground z:0 tag:0];
        [self addChild:bgLayer1 z:1 tag:1];
        [self addChild:bgLayer2 z:2 tag:2];
        [self addChild:boat z:3 tag:3];
//        [self addChild:enemy z:4 tag:4];
//        [self addChild:projectile z:4 tag:5];
        
        [bgLayer1 startup];
        [bgLayer2 startup];
         self.isTouchEnabled = YES;
        [boat startup];
//        [enemy startup];
        [self startup];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void) LoadContent
{
    
    spawnTime = 0.01f;
    
    mainBackground = [[CCSprite alloc]initWithFile:@"Content/mainbackground.png"];
    [mainBackground setAnchorPoint:CGPointMake(0,0)];
    [mainBackground setPosition:CGPointMake(0, 0)];
    
    bgLayer1 = [[ParallaxingBackground alloc]initWithSpeed:@"Content/bgLayer1.png" :self.contentSize.width:-2: 0.08f];
    [bgLayer1 setPosition:CGPointMake(0, 0)];
    
    bgLayer2 = [[ParallaxingBackground alloc]initWithSpeed:@"Content/bgLayer2.png":self.contentSize.width:-4: 0.05f];
    [bgLayer2 setPosition:CGPointMake(0, 0)];
    

//boat    
    Animation *player = [[Animation alloc]init];
    [player Initialize:@"Content/shipAnimation.png":@"shipAnimation" :CGPointMake(0, 0) :115 :69 :8 :30 :[UIColor whiteColor] :1.0f :YES];
    
    boat = [[Boat alloc]Initialize:player :CGPointMake(0, self.contentSize.height/2-69)];
    playerMoveSpeed = 8.0f;
    
    
//enemys
    enemyAnimation = [[Animation alloc]init];
    [enemyAnimation Initialize:@"Content/mineAnimation.png":@"mineAnimation" :CGPointMake(0, 0) :47: 61: 8: 30: [UIColor whiteColor] :0.08f :YES];
    
//    enemy = [[Enemy alloc]Initialize:enemyAnimation :CGPointMake(self.contentSize.width-50, self.contentSize.height/2-69)];
    
    
    enemys = [[NSMutableArray alloc] init];
    
    previousSpawnTime = 0;
    enemySpawnTime = spawnTime;//0.01f;

    
//laser
    
    laserString = @"Content/laser.png";
    [[CCTextureCache sharedTextureCache]addImage:laserString];
    
//    projectile = [[Projectile alloc]InitializeWithViewport:self.boundingBox :@"Content/laser.png":CGPointMake(0, 0)];
    
    
    projectiles = [[NSMutableArray alloc] init];
    
    fireTime = 0.15f;
    previousFireTime = 0;
    

//explosion
    explosionAnimation = [[Animation alloc]init];
    [explosionAnimation Initialize:@"Content/explosion.png" :@"explosion" :CGPointMake(0, 0) :134: 134: 12: 45: [UIColor whiteColor] : 1.0f:NO];
    
    explosions = [[NSMutableArray alloc] init];
    
}
- (void) UnloadContent
{}

- (void) updateSelf
{
    [self updateEnemy];
    [self updateCollision];
    [self UpdateProjectiles];
    [self updateExplosion];
}

-(void) startup
{
    [self schedule:@selector(updateSelf) interval:spawnTime];
}

- (void) addEnemy
{
    int _vh = self.contentSize.height-enemyAnimation.FrameHeight;
    int _vy = arc4random()%_vh; 
    Enemy *_enemy = [[Enemy alloc]Initialize:enemyAnimation :CGPointMake(self.contentSize.width+enemyAnimation.FrameWidth/2, _vy)];
    [enemys addObject:_enemy];
    [self addChild:_enemy z:3 tag:4];
    [_enemy startup];
}

- (void)updateEnemy
{
    previousSpawnTime += enemySpawnTime;
    
    if(previousSpawnTime >=1){
        previousSpawnTime = 0;
        [self addEnemy];
    }
    for(int i=[enemys count] -1;i>=0;i--)
    {
        Enemy *_enemy = [enemys objectAtIndex:i];
        [_enemy update];
        //[_enemy updateWithPosition:boat.position];
        
        if(_enemy.Active == NO){
            if (_enemy.health <= 0)
            {
                [self addExplosion:CGPointMake(_enemy.position.x-[_enemy getWidth], _enemy.position.y-[_enemy getHeight]/2)];
            }
            [_enemy stoped];
            [enemys removeObjectAtIndex:i];
            [self removeChild:_enemy cleanup:YES];
        }
    }
}
/*
private void AddProjectile(Vector2 position)
{
    Projectile projectile = new Projectile();
    projectile.Initialize(GraphicsDevice.Viewport, projectileTexture, position);
    projectiles.Add(projectile);
}
*/

- (void) addExplosion:(CGPoint)_point
{
    if(explosions){
        Explosion *_explosion = [[Explosion alloc]initWithPosition:explosionAnimation :_point];
        [explosions addObject:_explosion];
        [self addChild:_explosion z:4 tag:6];
        [_explosion startup];
    }
}
- (void) updateExplosion
{
    /*
     for (int i = explosions.Count - 1; i >= 0; i--)
     {
     explosions[i].Update(gameTime);
     if (explosions[i].Active == false)
     {
     explosions.RemoveAt(i);
     }
     }
     */
    for(int i= [explosions count]-1; i>=0; i--)
    {
        Explosion *_explosion = [explosions objectAtIndex:i];
        if(_explosion.Active == NO)
        {
            [_explosion stoped];
            [explosions removeObjectAtIndex:i];
            [self removeChild:_explosion cleanup:YES];
        }
    }
}

- (void) addProjectile:(CGPoint)_position
{
    if(projectiles){
        Projectile *_projectile = [[Projectile alloc]InitializeWithViewport:self.boundingBox :@"Content/laser.png":_position];
        [projectiles addObject:_projectile];
        [self addChild:_projectile z:2 tag:5];
    }
}
- (void) UpdateProjectiles
{
    for (int i=[projectiles count]-1; i>=0; i--) {
        Projectile *_projectile = [projectiles objectAtIndex:i];
        [_projectile update];
        if(_projectile.Active == NO)
        {
            [projectiles removeObjectAtIndex:i];
            [self removeChild:_projectile cleanup:YES];
        }
    }
}

- (void)updateCollision
{
    CGRect rectangle1;
    CGRect rectangle2;
    
    rectangle1 = CGRectMake(boat.position.x,boat.position.y, [boat getWidth], [boat getHeight]);
    
    for (int i=0; i<[enemys count]; ++i) {
        Enemy *_enemy = [enemys objectAtIndex:i];
        rectangle2 = CGRectMake(_enemy.position.x, _enemy.position.y, [_enemy getWidth], [_enemy getHeight]);
        
        // Determine if the two objects collided with each
        // other
        if(CGRectIntersectsRect(rectangle1, rectangle2))
        {
            // Subtract the health from the player based on
            // the enemy damage
            boat.health -= _enemy.damage;
            // Since the enemy collided with the player
            // destroy it
            _enemy.health = 0;
            
             // If the player health is less than zero we died
            if(boat.health<=0)
            {
                boat.Active = NO;
            }
        }
    }
    
    for(int i =0;i<[projectiles count];++i)
    {
        for(int j = 0;j< [enemys count];++j)
        {
            Projectile *_projectile = [projectiles objectAtIndex:i];
            rectangle1 = CGRectMake(_projectile.position.x-[_projectile getWidth]/2, _projectile.position.y-[_projectile getHeight]/2,[_projectile getWidth] , [_projectile getHeight]);
            
            Enemy *_enemy = [enemys objectAtIndex:j];
//            rectangle2 = CGRectMake(_enemy.position.x-[_enemy getWidth]/2, _enemy.position.y - [_enemy getHeight]/2, [_enemy getWidth], [_enemy getHeight]);
            rectangle2 = CGRectMake(_enemy.position.x-[_enemy getWidth]/2, _enemy.position.y, [_enemy getWidth], [_enemy getHeight]);
            
            // Determine if the two objects collided with each other
            if(CGRectIntersectsRect(rectangle1, rectangle2))
            {

                _enemy.health -= _projectile.damage;
                _projectile.Active = NO;
            }

            
        }
    }
}


- (void) shoot
{
    [self addProjectile:laserPointion];
}

/// event below:

//Called when a finger just begins touching the screen:  
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  
{
    UITouch *touch = [touches anyObject];  
    CGPoint touchLocation = [touch locationInView: [touch view]];  
    //    return [[CCDirector sharedDirector] convertToGL:touchLocation];
//    NSLog(@"touch began x = %f, y=%f",touchLocation.x,touchLocation.y);
    
    pointx=touchLocation.x-boat.position.x;
    pointy=touchLocation.y-(self.contentSize.height -boat.position.y);
    
    [self schedule:@selector(shoot) interval:fireTime];
    
    laserPointion = CGPointMake(boat.position.x+[boat getWidth]/2, boat.position.y+[boat getHeight]/2-5);
}

//Called whenever the finger moves on the screen:  
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event  
{
    UITouch *touch = [touches anyObject];  
    CGPoint touchLocation = [touch locationInView: [touch view]]; 
    CGPoint _point = boat.position;
    
    CGPoint _p;
    _p.x=touchLocation.x-pointx;
    _p.y=self.contentSize.height - (touchLocation.y-pointy); 
    
    if(_p.x > -20&& _p.x<self.contentSize.width-[boat getWidth])
        _point.x = _p.x;
    if(_p.y >0 && _p.y< self.contentSize.height-[boat getHeight])
        _point.y = _p.y;
    
    //id move = [CCMoveTo actionWithDuration:0.3f position:_p];
    //[boat runAction:move];
    laserPointion = CGPointMake(_point.x+[boat getWidth]/2, _point.y+[boat getHeight]/2-5);
    [boat setPosition:_point];
    
    
    /*
     CGPoint point = boat.position;
     
     NSLog(@"x = %f , y = %f , location x = %f , location y = %f",point.x,point.y,locationInView.x,locationInView.y);
     
     _p.x=locationInView.x-pointx;
     _p.y=locationInView.y-pointy;
     
     if(_p.x > 0&& _p.x<frame_width-[boat getWidth])
     point.x = _p.x;
     if(_p.y >0 && _p.y< frame_height-[boat getHeight])
     point.y = _p.y;
     
     
     [boat setPosition:point];

     */
}

//Called when a finger is lifted off the screen:  
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  
{
    [self unschedule:@selector(shoot)];
}

//Called to cancel a touch:  
-(void) ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event  
{}



@end
