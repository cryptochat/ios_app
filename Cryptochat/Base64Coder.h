//
//  Base64Coder.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Coder : NSObject

- (NSString *)encodedStringFromBase64Data:(NSData *)base64Data;
- (NSData *)decodedBase64StringFromString:(NSString *)base64String;

@end
