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
#import "Base64Coder.h"

@interface AuthService()
@property(strong, nonatomic)ServiceAPI* serviceAPI;
@property(strong, nonatomic)AuthParser* authParser;
@property(strong, nonatomic)Base64Coder* base64Coder;

@end

@implementation AuthService

-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.authParser = [AuthParser new];
        self.base64Coder = [Base64Coder new];
    }
    return self;
}

- (void)getPublicKeyFromServerWithComplete:(void (^)(TransportResponseStatus status, NSData *publicKey, NSString *identifier))completeResponse {
    [self.serviceAPI getPublicKeyWithCompleteResponse:^(NSDictionary *dicReponse, TransportResponseStatus status) {
        if (status != TransportResponseStatusSuccess) {
            completeResponse (status, nil, nil);
        } else {
            NSString *decodedKey = [self.base64Coder decodedBase64StringFromString:dicReponse[@"public_key"]];
            NSData *publicKey = [decodedKey dataUsingEncoding:NSUTF8StringEncoding];
            completeResponse (status, publicKey, dicReponse[@"identifier"]);
        }
    }];
}

- (void)sendMyPublicKeyToServerWithComplete:(void (^)(TransportResponseStatus status))completeResponse {
    //self.serviceAPI
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
