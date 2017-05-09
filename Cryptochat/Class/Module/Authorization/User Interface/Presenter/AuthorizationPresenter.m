//
//  AuthorizationAuthorizationPresenter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 19/03/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "AuthorizationPresenter.h"
#import "TransportLayer.h"
#import "Constants.h"


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

-(void)presentChatList{
    [self.userInterface hideProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.router presentChatList];
    });
    
}

@end
