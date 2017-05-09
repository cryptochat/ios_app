//
//  AuthorizationAuthorizationRouter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationRouter.h"
#import "AuthorizationPresenter.h"
#import "AuthorizationInteractor.h"
#import "AuthorizationViewController.h"
#import "UiKit/UIViewController.h"
#import "UiKit/UINavigationController.h"
#import "UiKit/UIView.h"
#import "AuthorizationDelegateInterface.h"
#import "ChatListRouter.h"


static NSString* nameStoryboard = @"Authorization";
static NSString* identifierViewController = @"AuthorizationViewController";

@interface AuthorizationRouter()

@property(weak, nonatomic)AuthorizationViewController *userInterface;
@property(weak, nonatomic)AuthorizationPresenter *presenter;

@end


@implementation AuthorizationRouter

- (void)presentAuthorizationInterfaceFromWindow:(UIWindow*)window
                                       delegate:(id<AuthorizationDelegateInterface>)delegate{
    
    AuthorizationViewController *regViewController = [self AuthorizationViewControllerFromStoryboard];
    self.userInterface = regViewController;
    [self configureDependencies];
    self.presenter.delegate = delegate;
  
    window.rootViewController = regViewController;
    [window makeKeyAndVisible];
}

-(void)configureDependencies{
    AuthorizationInteractor * interactor = [AuthorizationInteractor new];
    AuthorizationPresenter * presenter = [AuthorizationPresenter new];

    presenter.router = self;
    self.presenter = presenter;

    self.userInterface.presenter = presenter;
    self.presenter.userInterface = self.userInterface;

    self.presenter.interactor = interactor;
    interactor.presenter = presenter;
}

-(void)presentChatList{
    ChatListRouter* router = [ChatListRouter new];
    [router presentChatListInterfaceFromViewController:self.userInterface container:self.userInterface.view delegate:self.presenter];
    
}

-(AuthorizationViewController*)AuthorizationViewControllerFromStoryboard{
    UIStoryboard* storyboard = [self userStoryboard];
    AuthorizationViewController *vc = (id) [storyboard instantiateViewControllerWithIdentifier:identifierViewController];
    return vc;
}

-(UIStoryboard*)userStoryboard{
    return [UIStoryboard storyboardWithName:nameStoryboard bundle:[NSBundle mainBundle]];
}



@end
