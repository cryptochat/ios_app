//
//  MessageViewModel.m
//  Cryptochat
//
//  Created by Artem Konarev on 15.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

- (BOOL)isEqualToMessage:(MessageViewModel *)message{
    if (!message) {
        return NO;
    }
    
    BOOL isEqualAuthorType = (!self.authorType && !message.authorType) || (self.authorType == message.authorType);
    BOOL isEqualMessageText = (!self.messageText && !message.messageText) || [self.messageText isEqualToString:message.messageText];
    
    return isEqualAuthorType && isEqualMessageText;
}

@end
