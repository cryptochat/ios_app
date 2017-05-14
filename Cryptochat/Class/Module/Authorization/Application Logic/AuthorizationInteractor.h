//
//  AuthorizationAuthorizationInteractor.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationInteractorInterfaceIO.h"



@interface AuthorizationInteractor : NSObject <AuthorizationInteractorInterfaceInput>

@property (nonatomic, weak) id<AuthorizationInteractorInterfaceOutput> presenter;

@end
