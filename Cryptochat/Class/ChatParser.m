//
//  ChatParser.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ChatParser.h"
#import "InterlocutorModel.h"
#import "ChatListModel.h"

@implementation ChatParser

- (NSArray<InterlocutorModel *> *) createInterlocutorModelsArrayFromDictionary:(NSDictionary *)dictionary {
    if(dictionary == nil){
        return nil;
    }
    
    NSDictionary *dicChats = dictionary[@"cipher_message"];
    NSMutableArray *bufArray = [NSMutableArray new];
    
    for (NSDictionary *bufDic in dicChats[@"chats"]) {
        InterlocutorModel *model = [InterlocutorModel new];
        
        model.interlocutorID = bufDic[@"interlocutor"][@"id"];
        model.interlocutorUsername = bufDic[@"interlocutor"][@"username"];
        model.interlocutorFirstName = bufDic[@"interlocutor"][@"first_name"];
        model.interlocutorLastName = bufDic[@"interlocutor"][@"last_name"];
        
        [bufArray addObject:model];
    }

    return [NSArray arrayWithArray:bufArray];
}

- (NSArray<ChatListModel *> *) createChatListModelsArrayFromDictionary:(NSDictionary *)dictionary {
    if(dictionary == nil){
        return nil;
    }
    
    return nil;
}

@end
