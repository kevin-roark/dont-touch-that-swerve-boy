//
//  SwerveBoySpriteNode.m
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/10/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import "SwerveBoySpriteNode.h"

@implementation SwerveBoySpriteNode

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

@end
