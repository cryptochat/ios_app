//
//  AuthParser.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AuthorizationModel;

@interface AuthParser : NSObject
-(AuthorizationModel*)createAuthorizationModelFromResponse:(NSDictionary*)dicResponse;
@end
