//
//  SearchingSearchingPresenter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "SearchingPresenter.h"

@implementation SearchingPresenter


#pragma mark - SearchingViewInterfaceInputPresenter

-(void)viewInit{
    [self.interactor getModels];
}

#pragma mark -  <SearchingInteractorInterfaceOutput


-(void)updateView:(NSArray<SearchingModel*>*)arrModels{
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.userInterface updateView:arrModels];
    });
}
@end
