//
//  RegistrationRegistrationPresenter.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "UiKit/UIViewController.h"
#import "RegistrationViewInterfaceIO.h"
#import "RegistrationInteractorInterfaceIO.h"
#import "RegistrationRouter.h"



@interface RegistrationPresenter : NSObject <RegistrationInteractorInterfaceOutput, RegistrationViewInterfaceInputPresenter>

@property (nonatomic, weak) id<RegistrationViewInterfaceOutputView> userInterface;
@property (nonatomic, strong) id<RegistrationInteractorInterfaceInput> interactor;
@property (nonatomic, strong) RegistrationRouter* router;

@end
