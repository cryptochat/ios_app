//
//  AuthParser.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "AuthParser.h"
#import "UserAuthModel.h"



@implementation AuthParser
-(UserAuthModel*)createAuthorizationModelFromResponse:(NSDictionary*)dicResponse{
    if(dicResponse == nil){
        return nil;
    }
    
    UserAuthModel* authModel = [UserAuthModel new];

    authModel.uuid = dicResponse[@"cipher_message"][@"user"][@"uuid"];
    authModel.email = dicResponse[@"cipher_message"][@"user"][@"email"];
    authModel.username = dicResponse[@"cipher_message"][@"user"][@"username"];
    authModel.firstName = dicResponse[@"cipher_message"][@"user"][@"first_name"];
    authModel.lastName = dicResponse[@"cipher_message"][@"user"][@"last_name"];
    authModel.token = dicResponse[@"cipher_message"][@"user"][@"token"];

    return authModel;
}
@end
