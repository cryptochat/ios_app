//
//  Constants.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UiKit/UiKit.h"

static NSString* INVALID_EMAIL_MASK = @"Введите корректный email-адрес(например user@info.ru)";
static NSString* INVALID_PASSWORD = @"Введите пожалуйста пароль";

static NSString* NO_INTERNET_TEXT = @"Возникла проблема с интернет-соединением";
static NSString* ERROR_DEFAULT_TEXT = @"Возникла ошибка";
static NSString* ERROR_PARAMS = @"Неверно введены email или пароль";

@interface Constants : NSObject

@end
