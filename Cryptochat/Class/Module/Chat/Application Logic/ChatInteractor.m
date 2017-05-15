//
//  ChatChatInteractor.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatInteractor.h"
#import "ChatService.h"

@interface ChatInteractor()<ChatServiceDelegate>
@property (strong, nonatomic)ChatService *chatService;
@end


@implementation ChatInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        self.chatService = [ChatService new];
    }
    
    return self;
}

-(void)findChatWithID:(NSNumber*)chatID offset:(NSNumber*)offset limit:(NSNumber*)limit {
    
    [self.chatService getChatHistoryWithID:[NSString stringWithFormat:@"%@",chatID] limit:limit.intValue offset:offset.intValue complete:^(TransportResponseStatus status, NSArray<ChatMessageModel *> *arrHistory) {
        [self.presenter foundChat:arrHistory];
    }];
    
}
@end
