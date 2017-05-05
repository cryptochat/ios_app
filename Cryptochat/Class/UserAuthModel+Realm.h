//
//  UserAuthModel+Realm.h
//  mimigram
//
//  Created by Антон  Смирнов on 14.04.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAuthModel.h"
@class UserAuthRealm;

@interface UserAuthModel(Realm)
-(instancetype)initWithRealm:(UserAuthRealm*)realm;
@end
