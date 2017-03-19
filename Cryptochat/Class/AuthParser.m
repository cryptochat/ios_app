//
//  AuthParser.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "AuthParser.h"
#import "AuthorizationModel.h"



@implementation AuthParser
-(AuthorizationModel*)createAuthorizationModelFromResponse:(NSDictionary*)dicResponse{
    if(dicResponse == nil){
        return nil;
    }
    
    AuthorizationModel* authModel = [AuthorizationModel new];
    if([dicResponse[@"status"] isEqualToString:@"400"]){
        authModel.errorLogin = dicResponse[@"errors"][@"login"];
        authModel.errorPassword =dicResponse[@"errors"][@"password"];
        
    }
    
    if([dicResponse[@"status"] isEqualToString:@"OK"]){
        authModel.uuid = dicResponse[@"uuid"];
        authModel.email = dicResponse[@"email"];
        authModel.username = dicResponse[@"username"];
        authModel.firstName = dicResponse[@"first_name"];
        authModel.lastName = dicResponse[@"last_name"];
        authModel.token = dicResponse[@"token"];
    }
    return authModel;
}
@end
