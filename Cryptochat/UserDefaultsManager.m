//
//  UserDefaultsManager.m
//  mimigram
//
//  Created by Artem Konarev on 12.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UserDefaultsManager.h"


static NSString* IS_FIRST_START = @"IS_FIRST_START";


@implementation UserDefaultsManager

-(NSNumber*)getFirstStartFromUserDefaults{
    return [[NSUserDefaults standardUserDefaults] objectForKey:IS_FIRST_START];
}

-(void)setFirstStartToUserDefaults:(NSNumber*)firstStart{
    [[NSUserDefaults standardUserDefaults] setObject:firstStart forKey:IS_FIRST_START];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
