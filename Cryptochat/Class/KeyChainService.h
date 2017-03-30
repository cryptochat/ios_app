//
//  KeyChainService.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainService : NSObject

- (void)saveMyPublicKeyToKeyChain:(NSString *)puplicKey;
- (NSString *)myPublicKeyFromKeyChain;

@end
