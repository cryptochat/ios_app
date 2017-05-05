//
//  UserAuthRealm.h
//  mimigram
//
//  Created by Антон  Смирнов on 14.04.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Realm/Realm.h>

@interface UserAuthRealm : RLMObject
@property(strong, nonatomic)NSString* uuid;
@property(strong, nonatomic)NSString* email;
@property(strong, nonatomic)NSString* username;
@property(strong, nonatomic)NSString* firstName;
@property(strong, nonatomic)NSString* lastName;
@property(strong, nonatomic)NSString* token;
@end
