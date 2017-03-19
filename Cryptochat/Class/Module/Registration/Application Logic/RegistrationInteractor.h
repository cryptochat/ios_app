//
//  RegistrationRegistrationInteractor.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "RegistrationInteractorInterfaceIO.h"



@interface RegistrationInteractor : NSObject <RegistrationInteractorInterfaceInput>

@property (nonatomic, weak) id<RegistrationInteractorInterfaceOutput> presenter;

@end
