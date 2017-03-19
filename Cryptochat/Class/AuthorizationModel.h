//
//  AuthorizationModel.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorizationModel : NSObject
@property(strong, nonatomic)NSString* uuid;
@property(strong, nonatomic)NSString* email;
@property(strong, nonatomic)NSString* username;
@property(strong, nonatomic)NSString* firstName;
@property(strong, nonatomic)NSString* lastName;
@property(strong, nonatomic)NSString* token;
@property(strong, nonatomic)NSString* errorLogin;
@property(strong, nonatomic)NSString* errorPassword;
@end
