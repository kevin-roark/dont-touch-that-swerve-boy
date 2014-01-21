//
//  SwerveBoyMyScene.m
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/10/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import "SwerveBoyMyScene.h"

@implementation SwerveBoyMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        
        self.swerveBoy = [SwerveBoySpriteNode spriteNodeWithImageNamed:@"round_swerve_plain.png"];
        self.swerveBoy.position = [self getFrameCenter];
        self.swerveBoy.size = CGSizeMake(150, 150);
        
        self.shockedSwerveBoy = [SwerveBoySpriteNode spriteNodeWithImageNamed:@"round_swerve_shocked.png"];
        self.shockedSwerveBoy.position = self.swerveBoy.position;
        self.shockedSwerveBoy.size = self.swerveBoy.size;
        self.shockedSwerveBoy.colorBlendFactor = 0.55;
        
        self.dontTouchText1 = [[SwerveBoyRapidLabel alloc] initWithFontNamed:@"Arial"];
        self.dontTouchText1.text = @"DON'T TOUCH THAT";
        self.dontTouchText1.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 20);
        
        self.dontTouchText2 = [[SwerveBoyRapidLabel alloc] initWithFontNamed:@"Arial"];
        self.dontTouchText2.text = @"SWERVE BOY";
        self.dontTouchText2.position = CGPointMake(self.frame.size.width / 2, self.dontTouchText1.position.y - 30);
        
        self.seriouslyDontTouchText1 = [[SwerveBoyRapidLabel alloc] initWithFontNamed:@"Arial"];
        self.seriouslyDontTouchText1.text = @"SERIOUSLY QUIT";
        self.seriouslyDontTouchText1.position = CGPointMake(self.frame.size.width / 2, 100);
        
        self.seriouslyDontTouchText2 = [[SwerveBoyRapidLabel alloc] initWithFontNamed:@"Arial"];
        self.seriouslyDontTouchText2.text = @"TOUCHIN";
        self.seriouslyDontTouchText2.position =
            CGPointMake(self.frame.size.width / 2, self.seriouslyDontTouchText1.position.y - 30);
        
        self.seriouslyDontTouchText3 = [[SwerveBoyRapidLabel alloc] initWithFontNamed:@"Arial"];
        self.seriouslyDontTouchText3.text = @"THAT SWERVE BOY";
        self.seriouslyDontTouchText3.position =
            CGPointMake(self.frame.size.width / 2, self.seriouslyDontTouchText2.position.y - 30);
        
        self.dontTouchInThere = NO;
        self.seriousTextInThere = NO;
        self.colorChangeThreshold = 0.15;
        
        self.initialGrowthSpeed = 12.0;
        self.growthRate = self.swerveBoy.size.width / self.initialGrowthSpeed * 1.5;
        
        [self putSwerveBoyInThere];
        self.lastFrameTime = CACurrentMediaTime();
        self.lastColorChangeTime = CACurrentMediaTime();
    }
    return self;
}

- (CGPoint)getFrameCenter {
    return CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
}

- (void)putSwerveBoyInThere {
    [self.shockedSwerveBoy removeFromParent];
    self.shockedSwerveBoy.size = self.swerveBoy.size;
    self.shockedSwerveBoy.position = self.swerveBoy.position;
    [self.shockedSwerveBoy giveRandomTint];
    
    [self addChild:self.swerveBoy];
    self.swerveBoyInThere = YES;
    
    [self.seriouslyDontTouchText1 removeFromParent];
    [self.seriouslyDontTouchText2 removeFromParent];
    [self.seriouslyDontTouchText3 removeFromParent];
    [self.dontTouchText1 removeFromParent];
    [self.dontTouchText2 removeFromParent];
    
    self.dontTouchInThere = NO;
    self.seriousTextInThere = NO;
}

- (void)makeSwerveBoyShocked {
    [self.swerveBoy removeFromParent];
    self.lastFrameTime = CACurrentMediaTime();
    self.growthSpeed = self.initialGrowthSpeed;
    [self addChild:self.shockedSwerveBoy];
    self.swerveBoyInThere = NO;
    [self.swerveBoy resetToRandomPositionInFrame:self.frame];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if ([self.swerveBoy isPointInSprite:location] && self.swerveBoyInThere) {
            [self makeSwerveBoyShocked];
            
            [self.swerveController setScreamLooping];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.swerveBoyInThere) {
        [self putSwerveBoyInThere];
        
        [self.swerveController stopAllAudioLooping];
        [self.swerveController hideStatic];
    }
}

- (void)growSwerveBoy:(CFTimeInterval)timeSinceLastGrowth {
    CGFloat sizeDiff = self.growthSpeed * timeSinceLastGrowth;
    [self.shockedSwerveBoy runAction:[SKAction resizeByWidth:sizeDiff height:sizeDiff duration:0.0]];
    
    self.growthSpeed = MAX(self.shockedSwerveBoy.size.width / self.growthRate, self.initialGrowthSpeed);
}

- (void)handleSeriousText:(CFTimeInterval)currentTime {
    if (!self.seriousTextInThere) {
        [self addChild:self.seriouslyDontTouchText1];
        [self addChild:self.seriouslyDontTouchText2];
        [self addChild:self.seriouslyDontTouchText3];
        self.seriousTextInThere = YES;
    }
    
    if (currentTime - self.lastColorChangeTime >= self.colorChangeThreshold) {
        [self.seriouslyDontTouchText1 changeColor];
        self.seriouslyDontTouchText2.fontColor = self.seriouslyDontTouchText1.fontColor;
        self.seriouslyDontTouchText3.fontColor = self.seriouslyDontTouchText2.fontColor;
    }
}

- (void)handleDontTouchText:(CFTimeInterval)currentTime {
    if (!self.dontTouchInThere) {
        [self addChild:self.dontTouchText1];
        [self addChild:self.dontTouchText2];
        self.dontTouchInThere = YES;
    }
    
    if (currentTime - self.lastColorChangeTime >= self.colorChangeThreshold) {
        [self.dontTouchText1 changeColor];
        self.dontTouchText2.fontColor = self.dontTouchText1.fontColor;
        self.lastColorChangeTime = currentTime;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (!self.swerveBoyInThere) {
        CFTimeInterval timeDiff = currentTime - self.lastFrameTime;
        self.lastFrameTime = currentTime;
        
        [self growSwerveBoy:timeDiff];
        [self.shockedSwerveBoy updateTint];
        
        if (self.shockedSwerveBoy.size.width >= self.frame.size.width * 8) { // floating head on static
            if (!self.swerveController.showingFloatingHead) {
                [self.swerveController addFloatingStaticHead];
            }
            [self.swerveController adjustStaticSwerveBoyPosition:currentTime];
        }
        if (self.shockedSwerveBoy.size.width >= self.frame.size.width * 4) { // static mode
            if (!self.swerveController.showingStatic) {
                [self.swerveController produceStatic];
                [self.swerveController setWarpedLooping];
            }
            [self.swerveController adjustScreamVolumes:currentTime];
            [self.swerveController adjustStaticOpacity:currentTime];
        }
        if (self.shockedSwerveBoy.size.width >= self.frame.size.width * 2) { // bottom text
            [self handleSeriousText:currentTime];
        }
        if (self.shockedSwerveBoy.size.width >= self.frame.size.width) { // top text
            [self handleDontTouchText:currentTime];
        }
    }
}

@end
