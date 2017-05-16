//
//  ChatChatPresenter.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatPresenter.h"
#import "ChatMessageModel.h"
#import "MessageViewModel.h"

static NSInteger limit = 30;
static NSInteger defaultOffset = 0;

@implementation ChatPresenter

#pragma mark - ChatViewInterfaceInputPresenter

-(void)viewInit{
    [self.interactor findChatWithID:self.userID offset:@(defaultOffset) limit:@(limit)];
}

-(void)viewDownloadNewMessagesWithOffset:(NSNumber*)offset {
    [self.interactor findChatWithID:self.userID offset:offset limit:@(limit)];
}

-(void)viewSendMessage:(NSString *)message {
    [self.interactor sendMessageToUser:self.userID message:message];
    [self createMyNewMessageWithText:message];
}

#pragma mark -  <ChatInteractorInterfaceOutput
- (void)foundChat:(NSArray<ChatMessageModel *> *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *bufArray = [NSMutableArray new];
        
        for(ChatMessageModel *chatMessModel in message){
            MessageViewModel *viewModel = [MessageViewModel new];
            viewModel.userID = chatMessModel.valueID;
            viewModel.messageText = chatMessModel.message;
            viewModel.messageType = MessageTypeText;
            viewModel.authorType = chatMessModel.fromMe ? AuthorTypeMy : AuthorTypeNotMy;
            viewModel.userName = chatMessModel.userName;
            viewModel.userFirstName = chatMessModel.firstName;
            viewModel.userLastName = chatMessModel.lastName;
            viewModel.userURLAvatar = chatMessModel.avatarURL;
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm dd.MM.yy"];
            
            viewModel.date = [formatter stringFromDate:chatMessModel.createdDate];
            
            [bufArray addObject:viewModel];
        }
        
        [self.userInterface showDisplayMessages:bufArray];
    });
}

-(void)successSendMessage:(ChatMessageModel*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        MessageViewModel *viewModel = [MessageViewModel new];
        
        viewModel.userID = message.valueID;
        viewModel.messageText = message.message;
        viewModel.messageType = MessageTypeText;
        viewModel.authorType = AuthorTypeMy;
        viewModel.userName = message.userName;
        viewModel.userFirstName = message.firstName;
        viewModel.userLastName = message.lastName;
        viewModel.userURLAvatar = message.avatarURL;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm dd.MM.yy"];
        
        viewModel.date = [formatter stringFromDate:message.createdDate];
        
        [self.userInterface showConfirmSendMessage:viewModel];
    });
}

-(void)newSendOrIncomingMessage:(ChatMessageModel *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        MessageViewModel *viewModel = [MessageViewModel new];
        
        viewModel.userID = message.valueID;
        viewModel.messageText = message.message;
        viewModel.messageType = MessageTypeText;
        viewModel.authorType = AuthorTypeNotMy;
        viewModel.userName = message.userName;
        viewModel.userFirstName = message.firstName;
        viewModel.userLastName = message.lastName;
        viewModel.userURLAvatar = message.avatarURL;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm dd.MM.yy"];
        
        viewModel.date = [formatter stringFromDate:message.createdDate];

        [self.userInterface showDisplayNewMessages:@[viewModel]];
    });
}

#pragma mark - Private
-(void)createMyNewMessageWithText:(NSString*)text{
    MessageViewModel *myMessage = [MessageViewModel new];
    myMessage.messageText = text;
    myMessage.messageType = MessageTypeText;
    myMessage.authorType = AuthorTypeMy;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm dd.MM.yy"];
    myMessage.date = [formatter stringFromDate:date];
    
    [self.userInterface showDisplayNewMessages:@[myMessage]];
}


@end
