//
//  AuthService.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "AuthService.h"
#import "RealmDataStore.h"
#import "ServiceAPI.h"
#import "UserAuthModel.h"
#import "AuthViewModel.h"
#import "AuthParser.h"
#import "CryptoService.h"
#import "Base64Coder.h"
#import "KeyChainService.h"
#import "UserDefaultsManager.h"

const NSString* mockIdentifier = @"76c93ee0-20e3-4340-ab7b-ef1c2371dcda";

@interface AuthService()
@property(strong, nonatomic)ServiceAPI* serviceAPI;
@property(strong, nonatomic)AuthParser* authParser;
@property(strong, nonatomic)RealmDataStore* realmDataStore;
@property(strong, nonatomic)CryptoService* cryptService;
@property (strong, nonatomic) Base64Coder* base64Coder;
@property (strong, nonatomic) KeyChainService* keyChainService;
@property(strong, nonatomic)UserDefaultsManager* managerUD;

@end

@implementation AuthService
-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.authParser = [AuthParser new];
        self.realmDataStore = [RealmDataStore new];
        self.cryptService = [CryptoService new];
        self.base64Coder = [Base64Coder new];
        self.keyChainService = [KeyChainService new];
        self.managerUD = [UserDefaultsManager new];
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


-(void)authUserWithAuthViewModel:(AuthViewModel*)authViewModel WithCompleteResponse:(void (^)(TransportResponseStatus status, UserAuthModel* model ))completeResponse{
    
    NSDictionary* shoudCryptDict = @{
                                     @"email": authViewModel.email,
                                     @"password":authViewModel.password
                                     };
    [_cryptService encrypt:shoudCryptDict type:CryptTypeAuth complete:^(BOOL isOk, NSDictionary *validDict) {

        [_serviceAPI authUserWithIndetifier:[self.keyChainService getIdentifier] email:validDict[@"email"] password:validDict[@"password"] completeResponse:^(NSDictionary *dicReponse, TransportResponseStatus status) {
            if(status == TransportResponseStatusSuccess){
                
                UserAuthModel* authModel = [_authParser createAuthorizationModelFromResponse:dicReponse];
                NSDictionary* shoudCryptDict = @{
                                                 @"username": authModel.username,
                                                 @"uuid":authModel.uuid,
                                                 @"email":authModel.email,
                                                 @"firstName":authModel.firstName,
                                                 @"lastName":authModel.lastName,
                                                 @"token":authModel.token
                                                 };
                
                [_cryptService decrypt:shoudCryptDict type:CryptTypeAuth complete:^(BOOL isOk, NSDictionary *validDict) {
                    
                    authModel.email = validDict[@"email"];
                    authModel.uuid = validDict[@"uuid"];
                    authModel.username = validDict[@"username"];
                    authModel.firstName = validDict[@"firstName"];
                    authModel.lastName = validDict[@"lastName"];
                    authModel.token = validDict[@"token"];
                    
                    
                    //Сохраняем юзера в реалм
                    [_realmDataStore saveUser:authModel];
                    completeResponse(status, authModel );
                }];
            
            }else{
                completeResponse(status, nil);
            }
            
        }];

    }];
    
}


-(BOOL)isAuthorized{
    UserAuthModel* currentModel = [_realmDataStore getUser];
    if(!currentModel){
        return NO;
    }
    return YES;
}
@end
