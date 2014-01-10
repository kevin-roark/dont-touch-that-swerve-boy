//
//  SwerveBoyMyScene.h
//  Don't touch that swerve boy
//

//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SwerveBoySpriteNode.h"

@interface SwerveBoyMyScene : SKScene

@property (nonatomic, strong) SwerveBoySpriteNode *swerveBoy;
@property (nonatomic, strong) SwerveBoySpriteNode *shockedSwerveBoy;

@property (nonatomic) BOOL swerveBoyInThere;

@property (nonatomic) CFTimeInterval lastFrameTime;

@property (nonatomic) CGFloat initialGrowthSpeed;
@property (nonatomic) CGFloat growthSpeed;

@end
