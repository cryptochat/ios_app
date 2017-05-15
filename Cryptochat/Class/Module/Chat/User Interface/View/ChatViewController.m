//
//  ChatChatViewController.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatViewController.h"


@implementation ChatViewController

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];

	[self.presenter viewInit];
}

#pragma mark - ChatViewInterfaceOutputView <NSObject>



@end
