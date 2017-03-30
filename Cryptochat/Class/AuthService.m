//
//  AuthService.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "AuthService.h"
#import "ServiceAPI.h"
#import "AuthorizationModel.h"
#import "AuthViewModel.h"
#import "AuthParser.h"

@interface AuthService()
@property(strong, nonatomic)ServiceAPI* serviceAPI;
@property(strong, nonatomic)AuthParser* authParser;

@end

@implementation AuthService

-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.authParser = [AuthParser new];
    }
    return self;
}

- (void)getPublicKeyFromServerWithComplete:(void (^)(TransportResponseStatus status))completeResponse {
    [self.serviceAPI getPublicKeyWithCompleteResponse:^(NSDictionary *dicReponse, TransportResponseStatus status) {
        
    }];
}

- (void)sendMyPublicKeyToServerWithComplete:(void (^)(TransportResponseStatus status))completeResponse {
    self.serviceAPI
}

-(void)authUserWithAuthViewModel:(AuthViewModel*)authViewModel WithCompleteResponse:(void (^)(TransportResponseStatus status, AuthorizationModel* model ))completeResponse{
    [_serviceAPI authUserWithIndetifier:@"4fffbcc4-89a8-4016-a6fb-542f8c603bea" email:authViewModel.email password:authViewModel.password completeResponse:^(NSDictionary *dicReponse, TransportResponseStatus status) {
        if(status == TransportResponseStatusSuccess){
            
            //AuthorizationModel* authModel = [_authParser createAuthorizationModelFromResponse:dicReponse];
            //completeResponse(status, authModel );
            
        }else{
            //completeResponse(status, nil);
        }
        
    }];
}


@end
