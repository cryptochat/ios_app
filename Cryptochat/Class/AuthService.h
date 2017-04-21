//
//  AuthService.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceAPI.h"
@class AuthorizationModel;
@class AuthViewModel;

@interface AuthService : NSObject

- (void)getPublicKeyFromServerWithComplete:(void (^)(TransportResponseStatus status, NSData *publicKey, NSString *identifier))completeResponse;
- (void)sendMyPublicKeyToServer:(NSString *)myPublicKey identifier:(NSString *)identifier complete:(void (^)(TransportResponseStatus status))completeResponse;
-(void)authUserWithAuthViewModel:(AuthViewModel*)authViewModel WithCompleteResponse:(void (^)(TransportResponseStatus status, AuthorizationModel* model ))completeResponse;
@end
