//
//  ChatParser.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatListModel;
@class InterlocutorModel;

@interface ChatParser : NSObject

- (NSArray<InterlocutorModel *> *) createInterlocutorModelsArrayFromDictionary:(NSDictionary *)dictionary;
- (NSArray<ChatListModel *> *) createChatListModelsArrayFromDictionary:(NSDictionary *)dictionary;

@end
