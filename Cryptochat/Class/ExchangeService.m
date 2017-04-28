//
//  ExchangeService.m
//  Cryptochat
//
//  Created by Artem Konarev on 25.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ExchangeService.h"

#import "AuthService.h"
#import "KeyChainService.h"

@interface ExchangeService()

@property (strong, nonatomic) AuthService *authService;
@property (strong, nonatomic) KeyChainService *keyChanService;

@end

@implementation ExchangeService


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.authService = [AuthService new];
        self.keyChanService = [KeyChainService new];
    }
    return self;
}


- (void)keyExchangeWithCompleteStatus:(void (^)(TransportResponseStatus status))completeResponse {
    [self.authService getPublicKeyFromServerWithComplete:^(TransportResponseStatus status, NSData *publicKey) {
        if (publicKey) {
            [self.keyChanService createMySharedKeyFromPublicKey:publicKey];
            
            [self.authService sendMyPublicKeyToServerWithComplete:^(TransportResponseStatus status) {
                completeResponse (status);
            }];
        }
    }];
}

@end
