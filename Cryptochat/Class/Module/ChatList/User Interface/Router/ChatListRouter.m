//
//  ChatListChatListRouter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatListRouter.h"
#import "ChatListPresenter.h"
#import "ChatListInteractor.h"
#import "ChatListViewController.h"
#import "UiKit/UIViewController.h"
#import "UiKit/UINavigationController.h"
#import "UiKit/UIView.h"
#import "ChatListDelegateInterface.h"
#import "SearchingRouter.h"
#import "ChatRouter.h"

static NSString* nameStoryboard = @"ChatList";
static NSString* identifierViewController = @"ChatListViewController";

@interface ChatListRouter()

@property(weak, nonatomic)ChatListViewController *userInterface;
@property(weak, nonatomic)ChatListPresenter *presenter;
@property(strong, nonatomic)UINavigationController* navController;

@end


@implementation ChatListRouter

-(void)presentChatListInterfaceFromViewController:(UIViewController*)viewController
                                              container:(UIView*)container
                                               delegate:(id<ChatListDelegateInterface>)delegate{
    
    ChatListViewController* userInterface = [self ChatListViewControllerFromStoryboard];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:userInterface];
    self.navController = navController;
    
    self.userInterface = userInterface;
    [self configureDependencies];
    [userInterface.view setFrame:viewController.view.frame];
    self.presenter.delegate = delegate;
    
    [viewController.view addSubview:navController.view];
    [viewController addChildViewController:navController];
    [navController didMoveToParentViewController:viewController];
    
    [navController.view setFrame:container.bounds];
}

- (void)presentChatListInterfaceFromWindow:(UIWindow*)window
                                       delegate:(id<ChatListDelegateInterface>)delegate{
    
    ChatListViewController *userInterface = [self ChatListViewControllerFromStoryboard];
    self.userInterface = userInterface;
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:userInterface];
    self.navController = navController;
    
    [self configureDependencies];
    self.presenter.delegate = delegate;
    
    window.rootViewController = navController;
    [window makeKeyAndVisible];
}

-(void)configureDependencies{
    ChatListInteractor * interactor = [ChatListInteractor new];
    ChatListPresenter * presenter = [ChatListPresenter new];

    presenter.router = self;
    self.presenter = presenter;

    self.userInterface.presenter = presenter;
    self.presenter.userInterface = self.userInterface;

    self.presenter.interactor = interactor;
    interactor.presenter = presenter;
}

-(void)presentSearching{
    SearchingRouter* router = [SearchingRouter new];
    [router presentSearchingInterfaceFromNavController:self.navController delegate:self.presenter];
}

-(ChatListViewController*)ChatListViewControllerFromStoryboard{
    UIStoryboard* storyboard = [self userStoryboard];
    ChatListViewController *vc = (id) [storyboard instantiateViewControllerWithIdentifier:identifierViewController];
    return vc;
}

-(UIStoryboard*)userStoryboard{
    return [UIStoryboard storyboardWithName:nameStoryboard bundle:[NSBundle mainBundle]];
}


-(void)pushToChatWithUser:(NSNumber *)userID{
    ChatRouter *router = [ChatRouter new];
    [router pushChatInterfaceFromNavigationwController:self.navController userID:userID delegate:self.presenter];
}


@end
