//
//  ChatListChatListViewInterfaceIO.h
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatListViewModel;

@protocol ChatListViewInterfaceOutputView <NSObject>
-(void)showAlertMessage:(NSString *)message;
-(void)updateView:(NSArray<ChatListViewModel*>*)arrModels;

@end

@protocol ChatListViewInterfaceInputPresenter <NSObject>
-(void)viewInit;
-(void)presentSearching;
-(void)viewClickChat:(NSNumber*)userID;
@end
