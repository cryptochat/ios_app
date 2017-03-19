//
//  TransportLayer.h
//  mimigram
//
//  Created by Artem Konarev on 07.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TransportResponseStatus){
    TransportResponseStatusSuccess,
    TransportResponseStatusUnAuthorized,
    TransportResponseStatusBadRequest,
    TransportResponseStatusServerError,
    TransportResponseStatusNoInternet,
    TransportResponseStatusConflict,
    TransportResponseStatusNotFound,
};

@interface TransportLayer : NSObject

+(void)fetchRequest:(NSMutableURLRequest*)request
           complete:(void(^)(NSDictionary* dicReponse, TransportResponseStatus status, NSData* data))complete;

@end

