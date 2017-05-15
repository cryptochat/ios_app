//
//  ChatListChatListPresenter.h
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UiKit/UIViewController.h"
#import "ChatListViewInterfaceIO.h"
#import "ChatListInteractorInterfaceIO.h"
#import "ChatListRouter.h"
#import "ChatListDelegateInterface.h"
#import "SearchingDelegateInterface.h"
#import "ChatDelegateInterface.h"

@interface ChatListPresenter : NSObject <ChatListInteractorInterfaceOutput, ChatListViewInterfaceInputPresenter, SearchingDelegateInterface, ChatDelegateInterface>

@property (nonatomic, weak) id<ChatListViewInterfaceOutputView> userInterface;
@property (nonatomic, strong) id<ChatListInteractorInterfaceInput> interactor;
@property (nonatomic, strong) ChatListRouter* router;
@property(weak, nonatomic)id<ChatListDelegateInterface>delegate;
@end
