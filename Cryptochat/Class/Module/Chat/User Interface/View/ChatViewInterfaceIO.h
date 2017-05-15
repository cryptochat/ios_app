//
//  ChatChatViewInterfaceIO.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageViewModel;

@protocol ChatViewInterfaceOutputView <NSObject>

-(void)showDisplayMessages:(NSArray<MessageViewModel*>*)messages;
-(void)showHistoryMessages:(NSArray<MessageViewModel *> *)messages;
-(void)showConfirmSendMessage:(MessageViewModel*)message;
-(void)showDisplayNewMessages:(NSArray<MessageViewModel *> *)messages;
-(void)showDownloadingMessage;


@end

@protocol ChatViewInterfaceInputPresenter <NSObject>

-(void)viewInit;
-(void)viewDownloadNewMessagesWithOffset:(NSNumber*)offset;
-(void)viewSendMessage:(NSString *)message;
@end
