//
//  RealmDataStore.h
//  mimigram
//
//  Created by Artem Konarev on 21.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>


@class UserAuthModel;

@interface RealmDataStore : NSObject

-(void)removeAll;

-(void)saveUser:(UserAuthModel*)model;
-(void)updateUser:(UserAuthModel*)model;
-(UserAuthModel*)getUser;
-(void)removeUser;
@end
