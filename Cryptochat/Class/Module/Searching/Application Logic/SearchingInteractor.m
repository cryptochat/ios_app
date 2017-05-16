//
//  SearchingSearchingInteractor.m
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "SearchingInteractor.h"
#import "SearchingModel.h"
#import "UserService.h"
#import "AuthService.h"
#import "InterlocutorModel.h"

@interface SearchingInteractor()
@property(strong, nonatomic)UserService* userService;
@property(strong, nonatomic)AuthService* authService;
@end

@implementation SearchingInteractor

-(instancetype)init{
    self = [super init];
    if(self){
        _userService = [UserService new];
        _authService = [AuthService new];
    }
    return self;
}

-(void)getModelsWithQuery:(NSString *)query{
    
    [_userService getUsersWithToken:[_authService getAuthToken] query:query complete:^(TransportResponseStatus status, NSArray<InterlocutorModel *> *userArray) {
        
        NSMutableArray* buffArray = [NSMutableArray new];
        
        for(InterlocutorModel* intModel in userArray){
            SearchingModel* model = [SearchingModel new];
            model.name = [NSString stringWithFormat:@"%@ %@", intModel.interlocutorFirstName, intModel.interlocutorLastName];
            model.photoURL = intModel.interlocutorURLAvatar;
            [buffArray addObject:model];
            model.index = intModel.valueID.intValue;
        }
        [self.presenter updateView:buffArray];
    }];
    

}
@end
