//
//  ChatListChatListInteractorInterfaceIO.h
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransportLayer.h"
@class ChatListViewModel;

@protocol ChatListInteractorInterfaceInput <NSObject>
-(void)getModels;
@end

@protocol ChatListInteractorInterfaceOutput <NSObject>
-(void)updateView:(NSArray<ChatListViewModel*>*)arrModels;
-(void)showMessage:(TransportResponseStatus)status;
@end
