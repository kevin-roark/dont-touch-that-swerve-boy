//
//  SwerveColorFactory.m
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/13/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import "SwerveColorFactory.h"

@implementation SwerveColorFactory

+ (UIColor *) getRandomColor {
    CGFloat red = (arc4random() % 256) / 256.0; // 0.0 -> 1.0
    CGFloat green = (arc4random() % 256) / 256.0; // 0.0 -> 1.0
    CGFloat blue = (arc4random() % 256) / 256.0; // 0.0 -> 1.0;
    
    UIColor *c = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return c;
}

+ (UIColor *) getRandomSwerveColor {
    int idx = arc4random() % [[self swerveColors] count];
    return [[self swerveColors] objectAtIndex:idx];
}

+ (NSArray *) swerveColors {
    static NSArray *swerveColors = nil;
    
    if (swerveColors == nil) { // not initialized
        NSMutableArray *x = [[NSMutableArray alloc] init];
        [x addObject:[UIColor redColor]];
        [x addObject:[UIColor blueColor]];
        [x addObject:[UIColor greenColor]];
        swerveColors = x;
    }
    
    return swerveColors;
}

@end
