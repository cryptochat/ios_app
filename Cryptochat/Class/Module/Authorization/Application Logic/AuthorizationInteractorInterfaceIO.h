//
//  AuthorizationAuthorizationInteractorInterfaceIO.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AuthViewModel;

@protocol AuthorizationInteractorInterfaceInput <NSObject>
-(void)authUserWithModel:(AuthViewModel*)model;
@end

@protocol AuthorizationInteractorInterfaceOutput <NSObject>

@end
