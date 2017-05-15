//
//  ChatChatPresenter.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UiKit/UIViewController.h"
#import "ChatViewInterfaceIO.h"
#import "ChatInteractorInterfaceIO.h"
#import "ChatRouter.h"



@interface ChatPresenter : NSObject <ChatInteractorInterfaceOutput, ChatViewInterfaceInputPresenter>

@property (nonatomic, weak) id<ChatViewInterfaceOutputView> userInterface;
@property (nonatomic, strong) id<ChatInteractorInterfaceInput> interactor;
@property (nonatomic, strong) ChatRouter* router;

@property (strong, nonatomic) NSNumber *userID;

@end
