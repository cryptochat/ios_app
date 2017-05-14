//
//  UserModel.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (strong, nonatomic) NSNumber* userID;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* userFirstName;
@property (strong, nonatomic) NSString* userLastName;

@end
