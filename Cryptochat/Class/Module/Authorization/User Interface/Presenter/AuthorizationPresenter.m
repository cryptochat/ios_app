//
//  AuthorizationAuthorizationPresenter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationPresenter.h"
#import "TransportLayer.h"

static NSString* NO_INTERNET_TEXT = @"Возникла проблема с интернет-соединением";
static NSString* ERROR_DEFAULT_TEXT = @"Возникла ошибка";
static NSString* ERROR_PARAMS = @"Неверно введены email или пароль";

@implementation AuthorizationPresenter


#pragma mark - AuthorizationViewInterfaceInputPresenter

-(void)viewInit{
	
}

-(void)authUserWithModel:(AuthViewModel *)model{
    [self.userInterface showProgress];
    [self.interactor authUserWithModel:model];
}

#pragma mark -  <AuthorizationInteractorInterfaceOutput
-(void)showMessage:(TransportResponseStatus)status{
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (status) {
            case TransportResponseStatusNoInternet:
                [self.userInterface showAlertMessage:NO_INTERNET_TEXT];
                break;
            case TransportResponseStatusBadRequest:
                [self.userInterface showAlertMessage:ERROR_PARAMS];
                break;
    
            case TransportResponseStatusNotFound:
                [self.userInterface showAlertMessage:ERROR_PARAMS];
                break;
            default:
                [self.userInterface showAlertMessage:ERROR_DEFAULT_TEXT];
                break;
        }
    });
}

-(void)hideProgress{
    [self.userInterface hideProgress];
}

-(void)showProgress{
    [self.userInterface showProgress];
}

@end
