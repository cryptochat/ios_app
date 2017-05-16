//
//  SearchingSearchingRouter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "SearchingRouter.h"
#import "SearchingPresenter.h"
#import "SearchingInteractor.h"
#import "SearchingViewController.h"
#import "UiKit/UIViewController.h"
#import "UiKit/UINavigationController.h"
#import "UiKit/UIView.h"
#import "SearchingDelegateInterface.h"
#import "ChatRouter.h"

static NSString* nameStoryboard = @"ChatList";
static NSString* identifierViewController = @"SearchingViewController";

@interface SearchingRouter()<UISearchControllerDelegate, UISearchResultsUpdating>

@property(weak, nonatomic)SearchingViewController *userInterface;
@property(weak, nonatomic)SearchingPresenter *presenter;
@property(strong, nonatomic)UINavigationController* navController;
@property(strong,nonatomic)UISearchController* searchController;


@end


@implementation SearchingRouter

-(void)presentSearchingInterfaceFromNavController:(UINavigationController*)navController
                                             delegate:(id<SearchingDelegateInterface>)delegate{
    
    SearchingViewController* userInterface = [self SearchingViewControllerFromStoryboard];

    self.userInterface = userInterface;
    [self configureDependencies];
    
    self.navController = navController;
     _searchController = [[UISearchController alloc]initWithSearchResultsController:userInterface];
    _searchController.delegate = self;
    _searchController.searchBar.delegate = userInterface;
    _searchController.searchResultsUpdater = (id)self;
    
    
    self.presenter.delegate = delegate;
    
    [self.navController presentViewController:_searchController animated:YES completion:nil];
}

-(void)presentSearchingInterfaceFromNavigationController:(UINavigationController*)viewController
                                             container:(UIView*)container
                                              delegate:(id<SearchingDelegateInterface>)delegate{
    
    SearchingViewController* userInterface = [self SearchingViewControllerFromStoryboard];
    
    self.navController = viewController;
    self.userInterface = userInterface;
    [self configureDependencies];

    self.presenter.delegate = delegate;
    [userInterface.view setFrame:viewController.view.frame];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.navController.view.layer addAnimation:transition forKey:nil];

    
    [self.navController pushViewController:self.userInterface animated:NO];
    [self.navController.view setFrame:self.navController.view.frame];
}

-(void)configureDependencies{
    SearchingInteractor * interactor = [SearchingInteractor new];
    SearchingPresenter * presenter = [SearchingPresenter new];

    presenter.router = self;
    self.presenter = presenter;

    self.userInterface.presenter = presenter;
    self.presenter.userInterface = self.userInterface;

    self.presenter.interactor = interactor;
    interactor.presenter = presenter;
}

-(SearchingViewController*)SearchingViewControllerFromStoryboard{
    UIStoryboard* storyboard = [self userStoryboard];
    SearchingViewController *vc = (id) [storyboard instantiateViewControllerWithIdentifier:identifierViewController];
    return vc;
}

-(UIStoryboard*)userStoryboard{
    return [UIStoryboard storyboardWithName:nameStoryboard bundle:[NSBundle mainBundle]];
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    [self.navController setNavigationBarHidden: NO animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    _searchController.searchResultsController.view.hidden = NO;
}

-(void)pushToChatWithUser:(NSNumber *)userID{
    [self.userInterface dismissViewControllerAnimated:YES completion:nil];
    [self.navController setNavigationBarHidden: NO animated:YES];
    ChatRouter *router = [ChatRouter new];
    
    [router pushChatInterfaceFromNavigationwController:self.navController userID:userID delegate:self.presenter];
}

@end
