//
//  ChatListChatListRouter.h
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ChatListDelegateInterface.h"

@class UIView;
@class UIViewController;
@class UIWindow;
@class UINavigationController;

@interface ChatListRouter : NSObject
-(void)presentChatListInterfaceFromViewController:(UIViewController*)viewController
                                        container:(UIView*)container
                                         delegate:(id<ChatListDelegateInterface>)delegate;
- (void)presentChatListInterfaceFromWindow:(UIWindow*)window
                                  delegate:(id<ChatListDelegateInterface>)delegate;
- (void)pushChatListFromNavigationwController:(UINavigationController*)navigationController
                                     delegate:(id<ChatListDelegateInterface>)delegate;
-(void)presentSearching;
-(void)pushToChatWithUser:(NSNumber *)userID;

@end
