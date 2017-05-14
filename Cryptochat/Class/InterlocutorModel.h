//
//  InterlocutorModel.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterlocutorModel : NSObject

@property (strong, nonatomic) NSNumber* interlocutorID;
@property (strong, nonatomic) NSString* interlocutorUsername;
@property (strong, nonatomic) NSString* interlocutorFirstName;
@property (strong, nonatomic) NSString* interlocutorLastName;
@property (strong, nonatomic) NSURL* interlocutorURLAvatar;
@property (strong, nonatomic) NSURL* interlocutorURLAvatarBig;
@property (strong, nonatomic) NSURL* interlocutorURLAvatarMedium;
@property (strong, nonatomic) NSURL* interlocutorURLAvatarSmall;
@property (assign, nonatomic) BOOL isOnline;

@end
