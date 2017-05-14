//
//  UserAuthModel+Realm.m
//  mimigram
//
//  Created by Антон  Смирнов on 14.04.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UserAuthModel+Realm.h"
#import "UserAuthRealm.h"

@implementation UserAuthModel(Realm)
-(instancetype)initWithRealm:(UserAuthRealm*)realm{
    self = [super init];
    if(self){
        self.uuid = realm.uuid;
        self.email = realm.email;
        self.username = realm.username;
        self.firstName = realm.firstName;
        self.lastName = realm.lastName;
        self.token = realm.token;

    }
    return self;
}
@end
