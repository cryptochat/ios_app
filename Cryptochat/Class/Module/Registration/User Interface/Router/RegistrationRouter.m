//
//  RegistrationRegistrationRouter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "RegistrationRouter.h"
#import "RegistrationPresenter.h"
#import "RegistrationInteractor.h"
#import "RegistrationViewController.h"
#import "UiKit/UIViewController.h"
#import "UiKit/UINavigationController.h"
#import "UiKit/UIView.h"




#warning Заполните данные ниже
static NSString* nameStoryboard = @"";
static NSString* identifierViewController = @"";

@interface RegistrationRouter()

@property(weak, nonatomic)RegistrationViewController *userInterface;
@property(weak, nonatomic)RegistrationPresenter *presenter;

@end


@implementation RegistrationRouter

// NavigationController
/*
-(void)presentRegistrationInterfaceFromViewController:(UIViewController*)viewController{

     RegistrationViewController* userInterface = [self RegistrationViewControllerFromStoryboard];

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
-(void)presentRegistrationInterfaceFromViewController:(UIViewController*)viewController{

     RegistrationViewController* userInterface = [self RegistrationViewControllerFromStoryboard];

     self.userInterface = userInterface;
     [self configureDependencies];

     [viewController.view addSubview:userInterface.view];
     [viewController addChildViewController:userInterface];
     [userInterface didMoveToParentViewController:viewController];
}
*/

//View Piece
/*
-(void)presentRegistrationInterfaceFromViewController:(UIViewController*)viewController container:(UIView*)container{

    RegistrationViewController* userInterface = [self RegistrationViewControllerFromStoryboard];
    self.userInterface = userInterface;
    [self configureDependencies];

    [container addSubview:userInterface.view];
    [viewController addChildViewController:userInterface];
    [userInterface didMoveToParentViewController:viewController];
    [userInterface.view setFrame:container.bounds];
}

*/

-(void)configureDependencies{
    RegistrationInteractor * interactor = [RegistrationInteractor new];
    RegistrationPresenter * presenter = [RegistrationPresenter new];

    presenter.router = self;
    self.presenter = presenter;

    self.userInterface.presenter = presenter;
    self.presenter.userInterface = self.userInterface;

    self.presenter.interactor = interactor;
    interactor.presenter = presenter;
}

-(RegistrationViewController*)RegistrationViewControllerFromStoryboard{
    UIStoryboard* storyboard = [self userStoryboard];
    RegistrationViewController *vc = (id) [storyboard instantiateViewControllerWithIdentifier:identifierViewController];
    return vc;
}

-(UIStoryboard*)userStoryboard{
    return [UIStoryboard storyboardWithName:nameStoryboard bundle:[NSBundle mainBundle]];
}



@end
