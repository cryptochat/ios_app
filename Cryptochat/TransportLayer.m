//
//  TransportLayer.m
//  mimigram
//
//  Created by Artem Konarev on 07.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "TransportLayer.h"

@implementation TransportLayer

+(void)fetchRequest:(NSMutableURLRequest*)request
           complete:(void(^)(NSDictionary* dicReponse, TransportResponseStatus status, NSData* data))complete;{
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    
    NSURLSessionDataTask*task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse* httpReponse = (NSHTTPURLResponse*)response;
        
        if(error){
            complete(nil, TransportResponseStatusNoInternet, data);
            return;
        }
        
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        switch (httpReponse.statusCode) {
            case 500:
                complete(dictionary, TransportResponseStatusServerError, data);
                return;
                break;
            case 401:
                complete(dictionary, TransportResponseStatusUnAuthorized, data);
                return;
                break;
            case 409:
                complete(dictionary, TransportResponseStatusConflict, data);
                return;
                break;
            case 404:
                complete(dictionary, TransportResponseStatusNotFound, data);
                return;
                break;
            case 400:
                complete(dictionary, TransportResponseStatusBadRequest, data);
                return;
                break;
                
            default:
                break;
        }
        
        complete(dictionary, TransportResponseStatusSuccess, data);
    }];
    
    [task resume];
}

@end
