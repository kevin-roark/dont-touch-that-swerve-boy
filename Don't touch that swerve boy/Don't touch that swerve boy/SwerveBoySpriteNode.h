//
//  SwerveBoySpriteNode.h
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/10/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SwerveBoySpriteNode : SKSpriteNode

@property (nonatomic) CGFloat redVal;
@property (nonatomic) CGFloat greenVal;
@property (nonatomic) CGFloat blueVal;

- (BOOL)isPointInSprite:(CGPoint)point;

- (void)resetToRandomPositionInFrame:(CGRect)frame;

- (void)updateTint;

- (void)giveRandomTint;


@end
