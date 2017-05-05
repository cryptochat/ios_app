//
//  UserAuthModel.h
//  mimigram
//
//  Created by Антон  Смирнов on 13.04.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAuthModel : NSObject
@property(strong, nonatomic)NSString* uuid;
@property(strong, nonatomic)NSString* email;
@property(strong, nonatomic)NSString* username;
@property(strong, nonatomic)NSString* firstName;
@property(strong, nonatomic)NSString* lastName;
@property(strong, nonatomic)NSString* token;
@end
