//
//  AuthorizationAuthorizationPresenter.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UiKit/UIViewController.h"
#import "AuthorizationViewInterfaceIO.h"
#import "AuthorizationInteractorInterfaceIO.h"
#import "AuthorizationRouter.h"
#import "AuthorizationDelegateInterface.h"


@interface AuthorizationPresenter : NSObject <AuthorizationInteractorInterfaceOutput, AuthorizationViewInterfaceInputPresenter>

@property (nonatomic, weak) id<AuthorizationViewInterfaceOutputView> userInterface;
@property (nonatomic, strong) id<AuthorizationInteractorInterfaceInput> interactor;
@property (nonatomic, strong) AuthorizationRouter* router;
@property(weak, nonatomic)id<AuthorizationDelegateInterface> delegate;
@end
