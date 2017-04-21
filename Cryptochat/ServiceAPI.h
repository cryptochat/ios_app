//
//  ServiceAPI.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransportLayer.h"

typedef void(^APIServiceResponse)(NSDictionary*dicReponse, TransportResponseStatus status);

@interface ServiceAPI : NSObject
- (void)getPublicKeyWithCompleteResponse:(APIServiceResponse)completeResponse;
- (void)sendMyPublicKeyToServer:(NSString *)myPublicKey identifier:(NSString *)identifier complete:(APIServiceResponse)completeResponse;
-(void)authUserWithIndetifier:(NSString*)identifier email:(NSString*)email password:(NSString*)password completeResponse:(APIServiceResponse)completeResponse;
@end
