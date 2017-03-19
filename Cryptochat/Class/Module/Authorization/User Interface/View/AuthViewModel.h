//
//  AuthViewModel.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthViewModel : NSObject
@property(strong, nonatomic)NSString* email;
@property(strong, nonatomic)NSString* password;
@end
