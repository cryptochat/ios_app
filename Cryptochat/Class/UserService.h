//
//  UserService.h
//  Cryptochat
//
//  Created by Artem Konarev on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceAPI.h"

@class InterlocutorModel;

@interface UserService : NSObject

- (void)getUsersWithToken:(NSString *)token
                    query:(NSString *)query
                 complete:(void (^)(TransportResponseStatus status, NSArray<InterlocutorModel *> *userArray))completeResponse;

@end
