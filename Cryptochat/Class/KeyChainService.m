//
//  KeyChainService.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "KeyChainService.h"
#import "KeychainWrapper.h"

@implementation KeyChainService

- (void)saveMyPublicKeyToKeyChain:(NSString *)puplicKey {
    KeychainWrapper *keychain = [KeychainWrapper new];
    [keychain mySetObject:puplicKey forKey:(id)kSecValueData];
}

- (NSString *)myPublicKeyFromKeyChain {
    KeychainWrapper *keychain = [KeychainWrapper new];
    return [keychain myObjectForKey:(id)kSecValueData];
}

@end
