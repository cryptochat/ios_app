//
//  ChatChatViewController.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatViewInterfaceIO.h"

@interface ChatViewController : UIViewController <ChatViewInterfaceOutputView>

@property (nonatomic, strong) id<ChatViewInterfaceInputPresenter> presenter;

@end
