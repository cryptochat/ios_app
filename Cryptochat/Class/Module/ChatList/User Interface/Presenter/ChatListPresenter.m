//
//  ChatListChatListPresenter.m
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatListPresenter.h"
#import "Constants.h"

@implementation ChatListPresenter


#pragma mark - ChatListViewInterfaceInputPresenter

-(void)viewInit{
    [self.interactor getModels];
}

-(void)presentSearching{
    [self.router presentSearching];
}


#pragma mark -  <ChatListInteractorInterfaceOutput


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

-(void)updateView:(NSArray<ChatListViewModel*>*)arrModels{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.userInterface updateView:arrModels];
    });
}



@end
