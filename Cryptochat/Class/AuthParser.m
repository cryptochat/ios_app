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

    authModel.uuid = dicResponse[@"data"][@"uuid"];
    authModel.email = dicResponse[@"data"][@"email"];
    authModel.username = dicResponse[@"data"][@"username"];
    authModel.firstName = dicResponse[@"data"][@"first_name"];
    authModel.lastName = dicResponse[@"data"][@"last_name"];
    authModel.token = dicResponse[@"data"][@"token"];
    authModel.isValid = YES;

    return authModel;
}
@end
