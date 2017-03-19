//
//  AuthorizationAuthorizationRouter.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AuthorizationDelegateInterface.h"
@class UIView;
@class UIViewController;
@class UINavigationController;
@class UIWindow;


@interface AuthorizationRouter : NSObject
- (void)presentAuthorizationInterfaceFromWindow:(UIWindow*)window
                                       delegate:(id<AuthorizationDelegateInterface>)delegate;

@end
