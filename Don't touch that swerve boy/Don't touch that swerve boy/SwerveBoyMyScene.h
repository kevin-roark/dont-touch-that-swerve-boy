//
//  SwerveBoyMyScene.h
//  Don't touch that swerve boy
//

//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SwerveBoyViewController.h"
#import "SwerveBoySpriteNode.h"
#import "SwerveBoyRapidLabel.h"
#import "UIImage+animatedGIF.h"

@interface SwerveBoyMyScene : SKScene

@property (nonatomic, strong) SwerveBoyViewController *swerveController;

@property (nonatomic, strong) SwerveBoySpriteNode *swerveBoy;
@property (nonatomic, strong) SwerveBoySpriteNode *shockedSwerveBoy;

@property (nonatomic, strong) SwerveBoyRapidLabel *dontTouchText1;
@property (nonatomic, strong) SwerveBoyRapidLabel *dontTouchText2;

@property (nonatomic, strong) SwerveBoyRapidLabel *seriouslyDontTouchText1;
@property (nonatomic, strong) SwerveBoyRapidLabel *seriouslyDontTouchText2;
@property (nonatomic, strong) SwerveBoyRapidLabel *seriouslyDontTouchText3;

@property (nonatomic) CFTimeInterval lastColorChangeTime;
@property (nonatomic) CFTimeInterval colorChangeThreshold;

@property (nonatomic) BOOL swerveBoyInThere;
@property (nonatomic) BOOL dontTouchInThere;
@property (nonatomic) BOOL seriousTextInThere;

@property (nonatomic) CFTimeInterval lastFrameTime;

@property (nonatomic) CGFloat initialGrowthSpeed;
@property (nonatomic) CGFloat growthSpeed;

@property (nonatomic) CGFloat growthRate;

@end
