//
//  SearchingSearchingViewController.h
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchingViewInterfaceIO.h"

@interface SearchingViewController : UIViewController <SearchingViewInterfaceOutputView, UISearchBarDelegate>

@property (nonatomic, strong) id<SearchingViewInterfaceInputPresenter> presenter;

@end
