//
//  SearchingSearchingInteractorInterfaceIO.h
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchingModel;

@protocol SearchingInteractorInterfaceInput <NSObject>
-(void)getModels;
@end

@protocol SearchingInteractorInterfaceOutput <NSObject>
-(void)updateView:(NSArray<SearchingModel*>*)arrModels;
@end
