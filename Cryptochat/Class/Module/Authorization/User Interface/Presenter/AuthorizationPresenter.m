//
//  AuthorizationAuthorizationPresenter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationPresenter.h"

@implementation AuthorizationPresenter


#pragma mark - AuthorizationViewInterfaceInputPresenter

-(void)viewInit{
	
}

-(void)authUserWithModel:(AuthViewModel *)model{
    [self.interactor authUserWithModel:model];
}

#pragma mark -  <AuthorizationInteractorInterfaceOutput



@end
