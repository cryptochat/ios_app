//
//  ChatChatRouter.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatRouter.h"
#import "ChatPresenter.h"
#import "ChatInteractor.h"
#import "ChatViewController.h"
#import "UiKit/UIViewController.h"
#import "UiKit/UINavigationController.h"
#import "UiKit/UIView.h"




#warning Заполните данные ниже
static NSString* nameStoryboard = @"";
static NSString* identifierViewController = @"";

@interface ChatRouter()

@property(weak, nonatomic)ChatViewController *userInterface;
@property(weak, nonatomic)ChatPresenter *presenter;

@end


@implementation ChatRouter

// NavigationController
/*
-(void)presentChatInterfaceFromViewController:(UIViewController*)viewController{

     ChatViewController* userInterface = [self ChatViewControllerFromStoryboard];

     UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:userInterface];

     self.userInterface = userInterface;
     [self configureDependencies];

     [viewController.view addSubview:navController.view];
     [viewController addChildViewController:navController];
     [navController didMoveToParentViewController:viewController];
}
*/

//ViewController
/*
-(void)presentChatInterfaceFromViewController:(UIViewController*)viewController{

     ChatViewController* userInterface = [self ChatViewControllerFromStoryboard];

     self.userInterface = userInterface;
     [self configureDependencies];

     [viewController.view addSubview:userInterface.view];
     [viewController addChildViewController:userInterface];
     [userInterface didMoveToParentViewController:viewController];
}
*/

//View Piece
/*
-(void)presentChatInterfaceFromViewController:(UIViewController*)viewController container:(UIView*)container{

    ChatViewController* userInterface = [self ChatViewControllerFromStoryboard];
    self.userInterface = userInterface;
    [self configureDependencies];

    [container addSubview:userInterface.view];
    [viewController addChildViewController:userInterface];
    [userInterface didMoveToParentViewController:viewController];
    [userInterface.view setFrame:container.bounds];
}

*/

-(void)configureDependencies{
    ChatInteractor * interactor = [ChatInteractor new];
    ChatPresenter * presenter = [ChatPresenter new];

    presenter.router = self;
    self.presenter = presenter;

    self.userInterface.presenter = presenter;
    self.presenter.userInterface = self.userInterface;

    self.presenter.interactor = interactor;
    interactor.presenter = presenter;
}

-(ChatViewController*)ChatViewControllerFromStoryboard{
    UIStoryboard* storyboard = [self userStoryboard];
    ChatViewController *vc = (id) [storyboard instantiateViewControllerWithIdentifier:identifierViewController];
    return vc;
}

-(UIStoryboard*)userStoryboard{
    return [UIStoryboard storyboardWithName:nameStoryboard bundle:[NSBundle mainBundle]];
}



@end
