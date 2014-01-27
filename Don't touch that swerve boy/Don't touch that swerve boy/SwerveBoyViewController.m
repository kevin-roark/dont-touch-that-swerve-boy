//
//  SwerveBoyViewController.m
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/10/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import "SwerveBoyViewController.h"
#import "SwerveBoyMyScene.h"

@implementation SwerveBoyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SwerveBoyMyScene *scene = [SwerveBoyMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.swerveController = self;
    
    // Configure static gif
    self.staticImage = [UIImage animatedImageWithAnimatedGIFURL:
                        [[NSBundle mainBundle] URLForResource:@"static" withExtension:@"gif"]];
    self.staticImageView = [[UIImageView alloc] initWithImage:self.staticImage];
    self.staticImageView.alpha = 0.0;
    self.staticImageView.opaque = NO;
    self.staticImageView.contentMode = UIViewContentModeScaleToFill;
    self.staticImageView.frame = self.view.frame;
    self.showingStatic = NO;
    [self.view addSubview:self.staticImageView];
    
    // configure audio players
    self.normalAudioPlayer = [self makeAudioPlayerWithFile:@"/scream_cut_loop_1.aiff"];
    self.deepAudioPlayer = [self makeAudioPlayerWithFile:@"/scream_cut_loop_1_deep.aiff"];
    self.highAudioPlayer = [self makeAudioPlayerWithFile:@"/scream_cut_loop_1_high.aiff"];
    
    // configure copy of own swerve boy for weird static mode
    self.swerveBoy = [SwerveBoySpriteNode spriteNodeWithImageNamed:@"round_swerve_shocked.png"];
    self.swerveBoy.colorBlendFactor = 0.7;
    self.swerveBoy.size = CGSizeMake(scene.swerveBoy.size.width / 3, scene.swerveBoy.size.width / 3);
    self.swerveBoy.position = scene.swerveBoy.position;
    self.swerveBoy.zPosition = 5.0;
    self.swerveBoy.alpha = 1.0;
    self.swerveBoyFadedIn = NO;
    
    self.staticSwerveBoyScene = [[SKScene alloc] initWithSize:skView.bounds.size];
    self.staticSwerveBoyScene.backgroundColor = [UIColor clearColor];
    [self.staticSwerveBoyScene addChild:self.swerveBoy];
    self.showingFloatingHead = NO;
    
    self.staticSwerveBoyView = [[SKView alloc] initWithFrame:self.view.frame];
    self.staticSwerveBoyView.alpha = 0.0;
    self.staticSwerveBoyView.backgroundColor = [UIColor whiteColor];
    SKView *staticSKView = (SKView *)self.staticSwerveBoyView;
    [staticSKView presentScene:self.staticSwerveBoyScene];
    [self.view addSubview:staticSKView];
    
    // Present the scene.
    [skView presentScene:scene];
}

- (SwerveBoyAudioPlayer *)makeAudioPlayerWithFile:(NSString *)fileName {
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    resourcePath = [resourcePath stringByAppendingString:fileName];
    NSError* err;
    SwerveBoyAudioPlayer *p = [[SwerveBoyAudioPlayer alloc]
                               initWithContentsOfURL:[NSURL fileURLWithPath:resourcePath] error:&err];
    if( err ) {
        NSLog(@"Failed to create audio player with reason: %@", [err localizedDescription]);
    }
    else {
        p.delegate = self;
    }
    return p;
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
}

- (void)produceStatic {
    if (!self.showingStatic) {
        self.staticImageView.alpha = 0.01;
        self.lastStaticAdjustTime = CACurrentMediaTime();
        self.showingStatic = YES;
    }
}

- (void)hideStatic {
    if (self.showingStatic) {
        self.staticImageView.alpha = 0.0;
        self.showingStatic = NO;
    }
    if (self.showingFloatingHead) {
        self.showingFloatingHead = NO;
        [self removeStaticFloatingHead];
    }
}

- (void)adjustStaticOpacity:(CFTimeInterval)currentTime {
    if (currentTime - self.lastStaticAdjustTime >= 0.4) {
        self.staticImageView.alpha = MIN(self.staticImageView.alpha + 0.015, 1.0);
        self.lastStaticAdjustTime = currentTime;
    }
}

- (void)setScreamLooping {
    [self.normalAudioPlayer play];
    self.normalAudioPlayer.volume = 1.0;
}

- (void)stopScreamLooping {
    [self.normalAudioPlayer pause];
}

- (void)setWarpedLooping {
    [self.deepAudioPlayer play];
    [self.highAudioPlayer play];
    
    self.lastAudioAdjustTime = CACurrentMediaTime();
    self.deepAudioPlayer.volume = 0.01;
    self.highAudioPlayer.volume = 0.0;
    self.normalAudioPlayer.volume = 0.99;
}

- (void)stopWarpedLooping {
    [self.deepAudioPlayer pause];
    [self.highAudioPlayer pause];
}

- (void)stopAllAudioLooping {
    [self.deepAudioPlayer pause];
    [self.highAudioPlayer pause];
    [self.normalAudioPlayer pause];
}

- (void)adjustScreamVolumes:(CFTimeInterval)currentTime {
    if (currentTime - self.lastAudioAdjustTime >= 0.1) {
        self.deepAudioPlayer.volume = MIN(self.deepAudioPlayer.volume + 0.01, 2.0);
        self.highAudioPlayer.volume = self.deepAudioPlayer.volume / 28.0;
        self.normalAudioPlayer.volume = MAX(self.normalAudioPlayer.volume - 0.01, 0.05);
        self.lastAudioAdjustTime = currentTime;
    }
}

- (void)addFloatingStaticHead {
    if (!self.showingFloatingHead) {
        self.staticSwerveBoyView.alpha = 0.01;
        self.showingFloatingHead = YES;
    }
}

- (void)removeStaticFloatingHead {
    self.swerveBoyFadedIn = NO;
    self.staticSwerveBoyView.alpha = 0.0;
}

- (void)adjustStaticSwerveBoyPosition:(CFTimeInterval)currentTime {
    if (currentTime - self.lastStaticSwerveBoyAdjustTime >= 0.4) {
        [self.swerveBoy resetToRandomPositionInFrame:self.view.frame];
        self.lastStaticSwerveBoyAdjustTime = currentTime;
        if (!self.swerveBoyFadedIn) {
            self.staticSwerveBoyView.alpha = MIN(self.staticSwerveBoyView.alpha + 0.02, 0.6);
            if (self.staticSwerveBoyView.alpha > 0.59) {
                self.swerveBoyFadedIn = YES;
            }
        }
        else {
            self.staticSwerveBoyView.alpha = MAX(self.staticSwerveBoyView.alpha - 0.015, 0.0);
        }
    }
    [self.swerveBoy updateTint];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
