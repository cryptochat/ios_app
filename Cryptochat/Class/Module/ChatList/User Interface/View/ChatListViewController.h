//
//  ChatListChatListViewController.h
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatListViewInterfaceIO.h"

@interface ChatListViewController : UIViewController <ChatListViewInterfaceOutputView>

@property (nonatomic, strong) id<ChatListViewInterfaceInputPresenter> presenter;

@end
