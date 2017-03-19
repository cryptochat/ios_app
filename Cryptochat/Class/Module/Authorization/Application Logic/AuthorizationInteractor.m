//
//  AuthorizationAuthorizationInteractor.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationInteractor.h"
#import "AuthService.h"
@interface AuthorizationInteractor()
@property(strong, nonatomic)AuthService* authService;
@end

@implementation AuthorizationInteractor

-(instancetype)init{
    self = [super init];
    if(self){
        _authService = [AuthService new];
    }
    return self;
}

-(void)authUserWithModel:(AuthViewModel*)model{
    [_authService authUserWithAuthViewModel:model WithCompleteResponse:^(TransportResponseStatus status, AuthorizationModel *model) {
        
    }];
}
@end
