//
//  UserAuthRealm+Model.m
//  mimigram
//
//  Created by Антон  Смирнов on 14.04.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UserAuthRealm+Model.h"
#import "UserAuthModel.h"

@implementation UserAuthRealm(Model)
-(instancetype)initWithModel:(UserAuthModel*)model{
    self = [super init];
    if(self){
        self.uuid = model.uuid;
        self.email = model.email;
        self.username = model.username;
        self.firstName = model.firstName;
        self.lastName = model.lastName;
        self.token = model.token;
        
    }
    return self;
}

-(void)updateWithModel:(UserAuthModel*)model{
    self.uuid = model.uuid;
    self.email = model.email;
    self.username = model.username;
    self.firstName = model.firstName;
    self.lastName = model.lastName;
    self.token = model.token;
}


@end
