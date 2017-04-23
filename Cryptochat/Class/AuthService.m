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

@interface AuthService()
@property(strong, nonatomic)ServiceAPI* serviceAPI;
@property(strong, nonatomic)AuthParser* authParser;
@property(strong, nonatomic)RealmDataStore* realmDataStore;
@property(strong, nonatomic)CryptoService* cryptService;

@end

@implementation AuthService
-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.authParser = [AuthParser new];
        self.realmDataStore = [RealmDataStore new];
        self.cryptService = [CryptoService new];
    }
    return self;
}

-(void)authUserWithAuthViewModel:(AuthViewModel*)authViewModel WithCompleteResponse:(void (^)(TransportResponseStatus status, UserAuthModel* model ))completeResponse{
    
    NSDictionary* shoudCryptDict = @{
                                     @"email": authViewModel.email,
                                     @"password":authViewModel.password
                                     };
    [_cryptService encrypt:shoudCryptDict type:CryptTypeAuth complete:^(BOOL isOk, NSDictionary *validDict) {
        
        
#warning MOCK IDENTIFIER
        [_serviceAPI authUserWithIndetifier:@"76c93ee0-20e3-4340-ab7b-ef1c2371dcda" email:validDict[@"email"] password:validDict[@"password"] completeResponse:^(NSDictionary *dicReponse, TransportResponseStatus status) {
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
