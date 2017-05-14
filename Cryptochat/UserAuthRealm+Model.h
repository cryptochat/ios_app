//
//  UserAuthRealm+Model.h
//  mimigram
//
//  Created by Антон  Смирнов on 14.04.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAuthRealm.h"
@class UserAuthModel;

@interface UserAuthRealm(Model)
-(instancetype)initWithModel:(UserAuthModel*)model;
-(void)updateWithModel:(UserAuthModel*)model;
@end
