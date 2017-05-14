//
//  ChatListChatListInteractor.m
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatListInteractor.h"
#import "ChatListViewModel.h"
#import "ChatListModel.h"
#import "ChatService.h"
#import "AuthService.h"
#import "InterlocutorModel.h"

@interface ChatListInteractor()
@property(strong, nonatomic)ChatService* chatService;
@property(strong, nonatomic)AuthService* authService;
@end

@implementation ChatListInteractor

-(instancetype)init{
    self = [super init];
    if(self){
        _chatService = [ChatService new];
        _authService = [AuthService new];
    }
    return self;
}

-(void)getModels{
    
    [_chatService getChatListWithToken:[_authService getAuthToken] complete:^(TransportResponseStatus status, NSArray<InterlocutorModel *> *userArray, NSArray<ChatListModel *> *chatLustArray) {
        
        NSMutableArray<ChatListViewModel*>* buffArray = [NSMutableArray new];
        
        for(InterlocutorModel* intModel in userArray){
            ChatListViewModel* viewModel = [ChatListViewModel new];
            viewModel.name = [NSString stringWithFormat:@"%@ %@", intModel.interlocutorFirstName, intModel.interlocutorLastName];
            viewModel.isOnline = intModel.isOnline;
            viewModel.photoURL = intModel.interlocutorURLAvatar;
            viewModel.valueID = [intModel.valueID intValue];
            [buffArray addObject:viewModel];
        }
        
        for(ChatListViewModel* viewModel in buffArray){
            for(ChatListModel* chatModel in chatLustArray){
                if(viewModel.valueID == [chatModel.valueID intValue]){
                    viewModel.lastMessage = chatModel.lastMessage;
                    viewModel.isReaded = chatModel.isRead;
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"dd.MM.yy"];
                    viewModel.stringDate = [dateFormatter stringFromDate:chatModel.createdDate];
                }
            }
        }
        
        [self.presenter updateView:buffArray];
    }];
}

@end
