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
    
}

#pragma mark -  <ChatInteractorInterfaceOutput
- (void)foundChat:(NSArray<ChatMessageModel *> *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *bufArray = [NSMutableArray new];
        
        for(ChatMessageModel *chatMessModel in message){
            MessageViewModel *viewModel = [MessageViewModel new];
            viewModel.userID = @12;
            viewModel.messageText = chatMessModel.message;
            viewModel.messageType = MessageTypeText;
            viewModel.authorType = AuthorTypeNotMy;
            viewModel.userName = @"User";
            viewModel.userFirstName = @"User";
            viewModel.userLastName = @"User";
            viewModel.userURLAvatar = [NSURL URLWithString:@"wwww"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm dd.MM.yy"];
            
            viewModel.date = [formatter stringFromDate:chatMessModel.createdDate];
            
            [bufArray addObject:viewModel];
        }
        
        [self.userInterface showDisplayMessages:bufArray];
    });
}

@end
