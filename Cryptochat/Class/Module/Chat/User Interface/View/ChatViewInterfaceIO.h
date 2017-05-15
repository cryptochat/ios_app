//
//  ChatChatViewInterfaceIO.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChatViewInterfaceOutputView <NSObject>


@end

@protocol ChatViewInterfaceInputPresenter <NSObject>

-(void)viewInit;

@end
