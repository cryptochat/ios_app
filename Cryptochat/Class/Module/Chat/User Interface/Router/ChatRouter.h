//
//  ChatChatRouter.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ChatDelegateInterface.h"

@class UIView;
@class UIViewController;
@class UINavigationController;


@interface ChatRouter : NSObject

- (void)pushChatInterfaceFromNavigationwController:(UINavigationController*)navigationController
                                         userID:(NSNumber*)ID
                                          delegate:(id<ChatDelegateInterface>)delegate;

@end
