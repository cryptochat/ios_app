//
//  SearchingSearchingInteractor.m
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "SearchingInteractor.h"
#import "SearchingModel.h"

@interface SearchingInteractor()

@end

@implementation SearchingInteractor

-(void)getModels{
    NSMutableArray* buffArray = [NSMutableArray new];
    for(int i=0;i<6;i++){
        SearchingModel* model = [SearchingModel new];
        model.index = i;
        
        model.name = @"Евгений Петров";
        if(i==0){
            model.name = @"Михаил Андреев";
        }
        if(i==3){
            model.name = @"Андрей Васильев";
        }
        [buffArray addObject:model];
    }
    [self.presenter updateView:buffArray];
}
@end
