//
//  ChatListChatListInteractor.m
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatListInteractor.h"
#import "ChatListViewModel.h"

@interface ChatListInteractor()

@end

@implementation ChatListInteractor

-(void)getModels{
    
#warning MOCK DATA
    NSMutableArray* buffArray = [NSMutableArray new];
    for(int i=0;i<5;i++){
        ChatListViewModel* model = [ChatListViewModel new];
        model.name = @"Евгений Петров";
        model.lastMessage = @"Тестовое сообщение, проверка сообщения";
        model.stringDate = @"20.02.15";
        [buffArray addObject:model];
    }
    [self.presenter updateView:buffArray];
}

@end
