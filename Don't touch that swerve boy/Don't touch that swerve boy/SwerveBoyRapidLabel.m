//
//  SwerveBoyRapidLabel.m
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/13/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import "SwerveBoyRapidLabel.h"
#import "SwerveColorFactory.h"

@implementation SwerveBoyRapidLabel

- (id) initWithFontNamed:(NSString *)fontName {
    SwerveBoyRapidLabel *s = [super initWithFontNamed:fontName];
    s.fontColor = [UIColor whiteColor];
    s.fontSize = 30.0f;
    s.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    s.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    
    return s;
}

- (void) changeColor {
    UIColor *newColor = [SwerveColorFactory getRandomColor];
    self.fontColor = newColor;
}

@end
