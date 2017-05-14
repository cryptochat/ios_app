//
//  KeyChainService.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "KeyChainService.h"
#import "KeychainWrapper.h"

#import <Curve25519.h>
#import <Ed25519.h>
#import "Base64Coder.h"

@interface KeyChainService ()

@property (strong, nonatomic) KeychainWrapper *keychain;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) Base64Coder* base64Coder;
@end

static NSString *IdentifierKey = @"identifier";
static NSString *PublicKey = @"public_key";

@implementation KeyChainService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.base64Coder = [Base64Coder new];
        self.keychain = [KeychainWrapper new];
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}
- (void)createMySharedKeyFromPublicKey:(NSData *)publicKey {
    ECKeyPair *curve25519Key = [Curve25519 generateKeyPair];
    NSData *sharedSecret = [Curve25519 generateSharedSecretFromPublicKey:publicKey andKeyPair:curve25519Key];
    NSString *base64SharedKey = [self.base64Coder encodedStringFromBase64Data:sharedSecret];
    
    NSData *myPublicKey = curve25519Key.publicKey;
    [self.userDefaults setObject:myPublicKey forKey:PublicKey];
    [self.userDefaults synchronize];
    
    [self.keychain mySetObject:base64SharedKey forKey:(id)kSecValueData];
}

- (void)saveMyPublicKeyToKeyChain:(NSString *)puplicKey {
    [self.keychain mySetObject:puplicKey forKey:(id)kSecValueData];
}

- (NSData *)mySharedKeyFromKeyChain {
    NSString *base64SharedKey = [self.keychain myObjectForKey:(id)kSecValueData];
    return [self.base64Coder decodedBase64StringFromString:base64SharedKey];
}

- (void)saveIdentifier:(NSString *)identifier {
    [self.userDefaults setObject:identifier forKey:IdentifierKey];
    [self.userDefaults synchronize];
}

- (NSString *)getIdentifier {
    return [self.userDefaults objectForKey:IdentifierKey];
}

- (NSString *)getPublicKey {
    return [self.userDefaults objectForKey:PublicKey];
}

@end
