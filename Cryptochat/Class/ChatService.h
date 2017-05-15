//
//  ChatService.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceAPI.h"

@class InterlocutorModel;
@class ChatListModel;
@class ChatMessageModel;

typedef NS_ENUM(NSUInteger, ChatServiceStatus){
    ChatServiceStatusNotConnected,
    ChatServiceStatusConnected
};

@protocol ChatServiceDelegate <NSObject>

@optional

-(void)chatServiceChangeStatus:(ChatServiceStatus)status;
-(void)chatSerivceReceivedMessage:(ChatMessageModel*)message;
-(void)chatServiceSendSuccessMessage:(ChatMessageModel*)message;

@end


@interface ChatService : NSObject

- (void)getChatListWithToken:(NSString *)token
                    complete:(void (^)(TransportResponseStatus status, NSArray<InterlocutorModel *> *userArray, NSArray<ChatListModel *> *chatLustArray))completeResponse;


-(void)getChatHistoryWithID:(NSString*)interlocutorID
                      limit:(int)limit
                     offset:(int)offset
                   complete:(void(^)(TransportResponseStatus status, NSArray<ChatMessageModel*>* arrHistory))complete;

-(void)startConfigChat;

@end
