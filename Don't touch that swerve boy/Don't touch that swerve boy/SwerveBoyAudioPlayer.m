//
//  SwerveBoyAudioPlayer.m
//  Don't touch that swerve boy
//
//  Created by Kevin Roark on 1/21/14.
//  Copyright (c) 2014 Kevin Roark. All rights reserved.
//

#import "SwerveBoyAudioPlayer.h"

@implementation SwerveBoyAudioPlayer

- (id) initWithContentsOfURL:(NSURL *)url error:(NSError *__autoreleasing *)outError {
    SwerveBoyAudioPlayer *player = [super initWithContentsOfURL:url error:outError];
    
    if (player) {
        player.numberOfLoops = -1;
        player.currentTime = 0;
        player.volume = 1.0;
    }
    
    return player;
}

@end
