//
//  UserDefaultsManager.h
//  mimigram
//
//  Created by Artem Konarev on 12.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsManager : NSObject
-(NSNumber*)getFirstStartFromUserDefaults;
-(void)setFirstStartToUserDefaults:(NSNumber*)firstStart;
@end
