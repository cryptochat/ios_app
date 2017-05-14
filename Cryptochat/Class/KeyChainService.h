//
//  KeyChainService.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainService : NSObject

- (void)createMySharedKeyFromPublicKey:(NSData *)publicKey;
- (NSData *)mySharedKeyFromKeyChain;

//Identifier
- (void)saveIdentifier:(NSString *)identifier;
- (NSString *)getIdentifier;

//PublicKey
- (NSData *)getPublicKey;
@end
