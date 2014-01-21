//
//  SwerveBoyViewController.h
//  Don't touch that swerve boy
//

//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>
#import "SwerveBoyAudioPlayer.h"
#import "SwerveBoySpriteNode.h"

@interface SwerveBoyViewController : UIViewController<AVAudioPlayerDelegate>

@property (nonatomic) BOOL showingStatic;
@property (nonatomic, strong) UIImage *staticImage;
@property (nonatomic, strong) UIImageView *staticImageView;

@property (nonatomic, strong) SwerveBoyAudioPlayer *normalAudioPlayer;
@property (nonatomic, strong) SwerveBoyAudioPlayer *deepAudioPlayer;
@property (nonatomic, strong) SwerveBoyAudioPlayer *highAudioPlayer;

@property (nonatomic) BOOL showingFloatingHead;
@property (nonatomic, strong) SwerveBoySpriteNode *swerveBoy;
@property (nonatomic, strong) SKScene *staticSwerveBoyScene;
@property (nonatomic, strong) UIView *staticSwerveBoyView;

@property (nonatomic) BOOL swerveBoyFadedIn;
- (void) addFloatingStaticHead;
- (void) removeStaticFloatingHead;

@property (nonatomic) CFTimeInterval lastStaticSwerveBoyAdjustTime;
- (void) adjustStaticSwerveBoyPosition:(CFTimeInterval)currentTime;

- (void) produceStatic;
- (void) hideStatic;

- (void) setScreamLooping;
- (void) stopScreamLooping;

- (void) setWarpedLooping;
- (void) stopWarpedLooping;

@property (nonatomic) CFTimeInterval lastAudioAdjustTime;
- (void) adjustScreamVolumes:(CFTimeInterval)currentTime;

@property (nonatomic) CFTimeInterval lastStaticAdjustTime;
- (void) adjustStaticOpacity:(CFTimeInterval)currentTime;

- (void) stopAllAudioLooping;

@end
