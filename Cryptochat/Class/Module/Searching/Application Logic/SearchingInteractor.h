//
//  SearchingSearchingInteractor.h
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "SearchingInteractorInterfaceIO.h"



@interface SearchingInteractor : NSObject <SearchingInteractorInterfaceInput>

@property (nonatomic, weak) id<SearchingInteractorInterfaceOutput> presenter;

@end
