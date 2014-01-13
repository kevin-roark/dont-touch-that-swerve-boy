//
//  SwerveBoyMyScene.h
//  Don't touch that swerve boy
//

//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SwerveBoySpriteNode.h"
#import "SwerveBoyRapidLabel.h"

@interface SwerveBoyMyScene : SKScene<AVAudioPlayerDelegate>

@property (nonatomic, strong) SwerveBoySpriteNode *swerveBoy;
@property (nonatomic, strong) SwerveBoySpriteNode *shockedSwerveBoy;

@property (nonatomic, strong) SwerveBoyRapidLabel *dontTouchText;
@property (nonatomic, strong) SwerveBoyRapidLabel *seriouslyDontTouchText;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic) BOOL swerveBoyInThere;
@property (nonatomic) BOOL dontTouchInThere;
@property (nonatomic) BOOL seriousTextInThere;

@property (nonatomic) CFTimeInterval lastFrameTime;

@property (nonatomic) CGFloat initialGrowthSpeed;
@property (nonatomic) CGFloat growthSpeed;

@property (nonatomic) CGFloat growthRate;

@end
