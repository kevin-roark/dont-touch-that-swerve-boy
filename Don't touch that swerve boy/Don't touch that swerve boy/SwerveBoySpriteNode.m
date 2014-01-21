//
//  SwerveBoySpriteNode.m
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/10/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import "SwerveBoySpriteNode.h"

@implementation SwerveBoySpriteNode

CGFloat MAX_COLOR_T = 0.99;

+ (id)spriteNodeWithImageNamed:(NSString *)name {
    SwerveBoySpriteNode *n = [super spriteNodeWithImageNamed:name];
    n.redVal = 1.0;
    n.greenVal = 0.0;
    n.blueVal = 0.0;
    
    return n;
}

- (BOOL)isPointInSprite:(CGPoint)point {
    CGFloat xDiff = ABS(self.position.x - point.x);
    CGFloat yDiff = ABS(self.position.y - point.y);
    
    if (xDiff < self.size.width/2.0 && yDiff < self.size.height/2.0) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)resetToRandomPositionInFrame:(CGRect)frame {
    int xrange = frame.size.width - self.size.width;
    int yrange = frame.size.height - self.size.height;
    
    int x = (arc4random() % xrange) + self.size.width / 2;
    int y = (arc4random() % yrange) + self.size.height / 2;
    
    CGPoint p = CGPointMake(x, y);
    self.position = p;
}

- (void)updateTint {
    double growthAmount = drand48() * 0.02; // max of 0.02 growth rate, can always set to 0.01 to achieve as before
    
    if (self.redVal > MAX_COLOR_T) {
        if (self.blueVal > 0.01 && self.greenVal < 0.01) {
            self.blueVal -= growthAmount;
        }
        else if (self.blueVal < 0.01 && self.greenVal < 0.01) {
            self.blueVal = 0.0;
            self.greenVal = 0.02;
        }
        else if (self.blueVal < 0.01 && self.greenVal > 0.01 && self.greenVal < MAX_COLOR_T) {
            self.greenVal += growthAmount;
        }
        else {
            self.redVal = MAX_COLOR_T - 0.01;
            self.greenVal = 1.0;
        }
    }
    else if (self.greenVal > MAX_COLOR_T) {
        if (self.redVal > 0.01 && self.blueVal < 0.01) {
            self.redVal -= growthAmount;
        }
        else if (self.redVal < 0.01 && self.blueVal < 0.01) {
            self.redVal = 0.0;
            self.blueVal = 0.02;
        }
        else if (self.redVal < 0.01 && self.blueVal > 0.01 && self.blueVal < MAX_COLOR_T) {
            self.blueVal += growthAmount;
        }
        else {
            self.blueVal = 1.0;
            self.greenVal = MAX_COLOR_T - 0.01;
        }
    }
    else if (self.blueVal > MAX_COLOR_T) {
        if (self.greenVal > 0.01 && self.redVal < 0.01) {
            self.greenVal -= growthAmount;
        }
        else if (self.greenVal < 0.01 && self.redVal < 0.01) {
            self.greenVal = 0.0;
            self.redVal = 0.02;
        }
        else if (self.greenVal < 0.01 && self.redVal > 0.01 && self.redVal < MAX_COLOR_T) {
            self.redVal += growthAmount;
        }
        else {
            self.redVal = 1.0;
            self.blueVal = MAX_COLOR_T - 0.01;
        }
    }
    
    self.color = [UIColor colorWithRed:self.redVal green:self.greenVal blue:self.blueVal alpha:1.0];
}

- (void)giveRandomTint {
    CGFloat dominantColorVariable = drand48();
    if (dominantColorVariable < 0.33) { // red
        self.redVal = 1.0;
        self.blueVal = 0.0;
        self.greenVal = drand48() * MAX_COLOR_T - 0.01;
    }
    else if (dominantColorVariable > 0.33 && dominantColorVariable < 0.67) { // green
        self.greenVal = 1.0;
        self.redVal = 0.0;
        self.blueVal = drand48() * MAX_COLOR_T - 0.01;
        
    }
    else { // blue
        self.blueVal = 1.0;
        self.greenVal = 0.0;
        self.redVal = drand48() * MAX_COLOR_T - 0.01;
    }
}

@end
