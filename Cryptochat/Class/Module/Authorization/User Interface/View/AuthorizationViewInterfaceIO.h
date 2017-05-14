//
//  AuthorizationAuthorizationViewInterfaceIO.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthViewModel.h"

@protocol AuthorizationViewInterfaceOutputView <NSObject>
-(void)showAlertMessage:(NSString *)message;
-(void)showProgress;
-(void)hideProgress;

@end

@protocol AuthorizationViewInterfaceInputPresenter <NSObject>

-(void)viewInit;
-(void)authUserWithModel:(AuthViewModel*)model;


@end
