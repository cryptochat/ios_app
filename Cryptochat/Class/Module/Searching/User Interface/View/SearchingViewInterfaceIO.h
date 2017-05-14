//
//  SearchingSearchingViewInterfaceIO.h
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchingModel;

@protocol SearchingViewInterfaceOutputView <NSObject>
-(void)updateView:(NSArray<SearchingModel*>*)arrModels;
@end

@protocol SearchingViewInterfaceInputPresenter <NSObject>

-(void)viewInit;

@end
