//
//  AuthorizationAuthorizationViewController.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AuthorizationViewInterfaceIO.h"

@interface AuthorizationViewController : UIViewController <AuthorizationViewInterfaceOutputView>

@property (nonatomic, strong) id<AuthorizationViewInterfaceInputPresenter> presenter;

@end
