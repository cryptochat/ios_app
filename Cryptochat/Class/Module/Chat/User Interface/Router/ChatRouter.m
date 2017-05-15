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


static NSString* nameStoryboard = @"Chat";
static NSString* identifierViewController = @"ChatViewController";

@interface ChatRouter()

@property(weak, nonatomic)ChatViewController *userInterface;
@property(weak, nonatomic)ChatPresenter *presenter;
@property(weak, nonatomic)UINavigationController* currentNavigationController;
@end


@implementation ChatRouter

- (void)pushChatInterfaceFromNavigationwController:(UINavigationController*)navigationController
                                            userID:(NSNumber*)ID
                                          delegate:(id<ChatDelegateInterface>)delegate{
    
    ChatViewController* userInterface = [self ChatViewControllerFromStoryboard];
    
    self.userInterface = userInterface;
    self.currentNavigationController = navigationController;
    
    [self configureDependenciesWithUserID:ID];
    //[userInterface setBackType:ChatViewControllerNavigationController];
    [navigationController pushViewController:userInterface animated:YES];
}

-(void)configureDependenciesWithUserID:(NSNumber *)userID{
    ChatInteractor * interactor = [ChatInteractor new];
    ChatPresenter * presenter = [ChatPresenter new];

    presenter.router = self;
    self.presenter = presenter;
    self.presenter.userID = userID;

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
