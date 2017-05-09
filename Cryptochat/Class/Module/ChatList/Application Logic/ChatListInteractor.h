//
//  ChatListChatListInteractor.h
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatListInteractorInterfaceIO.h"



@interface ChatListInteractor : NSObject <ChatListInteractorInterfaceInput>

@property (nonatomic, weak) id<ChatListInteractorInterfaceOutput> presenter;

@end
