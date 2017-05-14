//
//  CRMediator.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CRMediator : NSObject
@property (strong, nonatomic)UIWindow *window;
@property (strong, nonatomic)UIViewController *viewController;

+ (CRMediator *)instance;
-(void)showAuthorization;
-(void)showChatList;

@end
