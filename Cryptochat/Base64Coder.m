//
//  Base64Coder.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "Base64Coder.h"

@implementation Base64Coder

- (NSString *)encodedStringFromBase64Data:(NSData *)base64Data {
    return [base64Data base64EncodedStringWithOptions:0];
}

- (NSString *)decodedBase64StringFromString:(NSString *)base64String {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

@end
