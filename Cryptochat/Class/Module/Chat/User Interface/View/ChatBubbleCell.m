//
//  ChatBubbleCell.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatBubbleCell.h"
#import "BubbleTextCell.h"

@implementation ChatBubbleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier
               andMessageType:(MessageType)messageType{
    
    if (self)
    {
        switch (messageType) {
            case MessageTypeText:
                self = [[BubbleTextCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
                break;
            case MessageTypeImage:
                
                break;
            case MessageTypeTyping:
                
                break;
                
        }
    }
    
    return self;
}

@end
