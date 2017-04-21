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

-(void)authUserWithAuthViewModel:(AuthViewModel*)authViewModel WithCompleteResponse:(void (^)(TransportResponseStatus status, AuthorizationModel* model ))completeResponse{
    
#warning MOCK IDENTIFIER
    [_serviceAPI authUserWithIndetifier:@"76c93ee0-20e3-4340-ab7b-ef1c2371dcda" email:authViewModel.email password:authViewModel.password completeResponse:^(NSDictionary *dicReponse, TransportResponseStatus status) {
        if(status == TransportResponseStatusSuccess){

            AuthorizationModel* authModel = [_authParser createAuthorizationModelFromResponse:dicReponse];
            completeResponse(status, authModel );
            
            
        }else{
            completeResponse(status, nil);
        }
        
    }];
}


@end
