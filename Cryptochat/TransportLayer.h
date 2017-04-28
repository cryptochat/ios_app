//
//  TransportLayer.h
//  mimigram
//
//  Created by Artem Konarev on 07.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TransportResponseStatus){
    TransportResponseStatusSuccess = 200,
    TransportResponseStatusUnAuthorized = 401,
    TransportResponseStatusBadRequest = 400,
    TransportResponseStatusServerError = 500,
    TransportResponseStatusNoInternet = 503,
    TransportResponseStatusConflict = 409,
    TransportResponseStatusNotFound = 404,
};

@interface TransportLayer : NSObject

+(void)fetchRequest:(NSMutableURLRequest*)request
           complete:(void(^)(NSDictionary* dicReponse, TransportResponseStatus status, NSData* data))complete;

@end

