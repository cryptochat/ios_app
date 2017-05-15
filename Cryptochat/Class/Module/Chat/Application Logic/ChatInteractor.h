//
//  ChatChatInteractor.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatInteractorInterfaceIO.h"



@interface ChatInteractor : NSObject <ChatInteractorInterfaceInput>

@property (nonatomic, weak) id<ChatInteractorInterfaceOutput> presenter;

@end
