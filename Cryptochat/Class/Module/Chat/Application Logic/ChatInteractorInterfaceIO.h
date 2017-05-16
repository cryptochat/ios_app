//
//  ChatChatInteractorInterfaceIO.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatMessageModel;

@protocol ChatInteractorInterfaceInput <NSObject>

-(void)findChatWithID:(NSNumber*)chatID offset:(NSNumber*)offset limit:(NSNumber*)limit;
-(void)sendMessageToUser:(NSNumber *)userID message:(NSString *)message;

@end

@protocol ChatInteractorInterfaceOutput <NSObject>

-(void)foundChat:(NSArray<ChatMessageModel*>*)message;
-(void)successSendMessage:(ChatMessageModel*)message;
@end
