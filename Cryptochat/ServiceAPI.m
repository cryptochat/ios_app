//
//  ServiceAPI.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 19.03.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ServiceAPI.h"

static NSString* BASE_API_URL = @"http://wishbyte.org/api/v1";

@implementation ServiceAPI

-(void)addRequestContentType:(NSMutableURLRequest*)request{
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}


#pragma mark - Authorization
-(void)getPublicKeyWithCompleteResponse:(APIServiceResponse)completeResponse{
    
    NSString* url = @"http://wishbyte.org/api/v1/key_exchanger/get_public";
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithString:url];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.URL = components.URL;
    request.HTTPMethod = @"GET";
    
    [self addRequestContentType:request];
  
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", url);
        completeResponse(dicReponse, status);
    }];
}

- (void)sendMyPublicKeyToServer:(NSString *)myPublicKey identifier:(NSString *)identifier complete:(APIServiceResponse)completeResponse {
    
    NSString* urlString = [NSString stringWithFormat:@"%@/key_exchanger/send_public", BASE_API_URL];
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithString:urlString];
    
    NSURLQueryItem *itemIdentifier = [NSURLQueryItem queryItemWithName:@"identifier" value:identifier];
    NSURLQueryItem *itemPublicKey = [NSURLQueryItem queryItemWithName:@"public_key" value:myPublicKey];
    components.queryItems = @[itemIdentifier, itemPublicKey];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.URL = components.URL;
    request.HTTPMethod = @"POST";
    
    [self addRequestContentType:request];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", urlString);
        completeResponse(dicReponse, status);
    }];

}

-(void)authUserWithIndetifier:(NSString*)identifier email:(NSString*)email password:(NSString*)password completeResponse:(APIServiceResponse)completeResponse{
    
    NSString* url = @"http://wishbyte.org/api/v1/users/auth";
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithString:url];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.URL = components.URL;
    request.HTTPMethod = @"POST";
    
    NSDictionary *jsonDictionary = @{
                                     @"identifier" : email,
                                     @"data[email]" : password,
                                     @"data[password]" : identifier,
                                     };
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody = jsonData;
    
    [self addRequestContentType:request];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", url);
        completeResponse(dicReponse, status);
    }];
}



@end
