//
//  SearchingSearchingPresenter.h
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UiKit/UIViewController.h"
#import "SearchingViewInterfaceIO.h"
#import "SearchingInteractorInterfaceIO.h"
#import "SearchingRouter.h"
#import "SearchingDelegateInterface.h"


@interface SearchingPresenter : NSObject <SearchingInteractorInterfaceOutput, SearchingViewInterfaceInputPresenter>

@property (nonatomic, weak) id<SearchingViewInterfaceOutputView> userInterface;
@property (nonatomic, strong) id<SearchingInteractorInterfaceInput> interactor;
@property (nonatomic, strong) SearchingRouter* router;
@property(weak, nonatomic)id<SearchingDelegateInterface>delegate;
@end
