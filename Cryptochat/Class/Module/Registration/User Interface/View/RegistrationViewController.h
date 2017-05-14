//
//  RegistrationRegistrationViewController.h
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RegistrationViewInterfaceIO.h"

@interface RegistrationViewController : UIViewController <RegistrationViewInterfaceOutputView>

@property (nonatomic, strong) id<RegistrationViewInterfaceInputPresenter> presenter;

@end
