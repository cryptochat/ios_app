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
    return [base64Data base64EncodedStringWithOptions:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)decodedBase64StringFromString:(NSString *)base64String {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:decodedData encoding:NSASCIIStringEncoding];
}

@end
