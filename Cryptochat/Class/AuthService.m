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
#import "KeyChainService.h"

@interface AuthService()
@property (strong, nonatomic) ServiceAPI* serviceAPI;
@property (strong, nonatomic) AuthParser* authParser;
@property (strong, nonatomic) Base64Coder* base64Coder;
@property (strong, nonatomic) KeyChainService* keyChainService;
@end

@implementation AuthService

-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.authParser = [AuthParser new];
        self.base64Coder = [Base64Coder new];
        self.keyChainService = [KeyChainService new];
    }
    return self;
}

- (void)getPublicKeyFromServerWithComplete:(void (^)(TransportResponseStatus status, NSData *publicKey))completeResponse {
    [self.serviceAPI getPublicKeyWithCompleteResponse:^(NSDictionary *dicReponse, TransportResponseStatus status) {
        if (status != TransportResponseStatusSuccess || !dicReponse) {
            completeResponse (status, nil);
        } else {
            NSData *decodedKey = [self.base64Coder decodedBase64StringFromString:dicReponse[@"public_key"]];
            [self.keyChainService saveIdentifier:dicReponse[@"identifier"]];
            
            completeResponse (status, decodedKey);
        }
    }];
}

- (void)sendMyPublicKeyToServerWithComplete:(void (^)(TransportResponseStatus status))completeResponse {
    
    NSString *base64Key = [self.base64Coder encodedStringFromBase64Data:[self.keyChainService getPublicKey]];
    [self.serviceAPI sendMyPublicKeyToServer:base64Key identifier:[self.keyChainService getIdentifier]
                                    complete:^(NSDictionary *dicReponse, TransportResponseStatus status) {
        completeResponse (status);
    }];
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
