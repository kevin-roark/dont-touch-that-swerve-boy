//
//  SwerveColorFactory.h
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/13/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwerveColorFactory : NSObject

+ (UIColor *) getRandomColor;

+ (NSArray *) swerveColors;
+ (UIColor *) getRandomSwerveColor;

@end
