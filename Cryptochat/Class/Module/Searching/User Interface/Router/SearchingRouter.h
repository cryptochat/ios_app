//
//  SearchingSearchingRouter.h
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SearchingDelegateInterface.h"
@class UIView;
@class UIViewController;
@class UINavigationController;


@interface SearchingRouter : NSObject
-(void)presentSearchingInterfaceFromNavigationController:(UINavigationController*)viewController
                                               container:(UIView*)container
                                                delegate:(id<SearchingDelegateInterface>)delegate;

-(void)presentSearchingInterfaceFromNavController:(UINavigationController*)navController
                                         delegate:(id<SearchingDelegateInterface>)delegate;
@end
