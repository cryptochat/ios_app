//
//  CRMediator.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "CRMediator.h"
#import "AuthorizationRouter.h"
#import "ChatListRouter.h"

@implementation CRMediator

+ (CRMediator *)instance{
    static CRMediator *_instance = nil;
    
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    
    return _instance;
}

-(void)showAuthorization{
    AuthorizationRouter* router = [AuthorizationRouter new];
    [router presentAuthorizationInterfaceFromWindow:self.window delegate:(id)self];
}

-(void)showChatList{
    ChatListRouter* router = [ChatListRouter new];
    [router presentChatListInterfaceFromWindow:self.window delegate:(id)self];
}


@end
