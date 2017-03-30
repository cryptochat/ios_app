//
//  KeyChainService.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "KeyChainService.h"
#import "KeychainWrapper.h"

@interface KeyChainService ()

@property (strong, nonatomic) KeychainWrapper *keychain;

@end

@implementation KeyChainService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keychain = [KeychainWrapper new];
    }
    
    return self;
}

- (void)saveMyPublicKeyToKeyChain:(NSString *)puplicKey {
    [self.keychain mySetObject:puplicKey forKey:(id)kSecValueData];
}

- (NSString *)myPublicKeyFromKeyChain {
    return [self.keychain myObjectForKey:(id)kSecValueData];
}

@end
