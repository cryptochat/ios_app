//
//  ChatChatInteractor.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatInteractor.h"
#import "ChatService.h"
#import "ChatMessageModel.h"

@interface ChatInteractor()<ChatServiceDelegate>
@property (strong, nonatomic)ChatService *chatService;
@end


@implementation ChatInteractor

- (instancetype)init {
    self = [super init];
    if (self) {
        self.chatService = [ChatService new];
        [self.chatService setDelegate:self];
        [self.chatService startConfigChat];
    }
    
    return self;
}

-(void)findChatWithID:(NSNumber*)chatID offset:(NSNumber*)offset limit:(NSNumber*)limit {
    
    [self.chatService getChatHistoryWithID:[NSString stringWithFormat:@"%@",chatID] limit:limit.intValue offset:offset.intValue complete:^(TransportResponseStatus status, NSArray<ChatMessageModel *> *arrHistory) {
        [self.presenter foundChat:arrHistory];
    }];
    
}

-(void)sendMessageToUser:(NSNumber *)userID message:(NSString *)message {
    ChatMessageModel *model = [ChatMessageModel new];
    model.message = message;
    model.valueID = userID;
    model.fromMe = YES;
    [self.chatService sendMessage:model];
}

-(void)chatServiceChangeStatus:(ChatServiceStatus)status {
    
}

-(void)chatSerivceReceivedMessage:(ChatMessageModel*)message {
    if (message.methodType == MethodTypeIncoming) {
        [self.presenter newSendOrIncomingMessage:message];
    }
}

-(void)chatServiceMessageConfirmed:(ChatMessageModel*)message {
    [self.presenter successSendMessage:message];
}


@end
