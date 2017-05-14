//
//  ChatService.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceAPI.h"

@class UserModel;
@class ChatListModel;

@interface ChatService : NSObject

- (void)getChatListWithToken:(NSString *)token
                    complete:(void (^)(TransportResponseStatus status, NSArray<UserModel *> *userArray, NSArray<ChatListModel *> *chatLustArray))completeResponse;

@end
