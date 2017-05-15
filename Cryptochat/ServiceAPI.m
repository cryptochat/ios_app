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
    

    NSString* strURL = [NSString stringWithFormat:@"%@/users/auth",BASE_API_URL];
    
    NSDictionary* dataDict = @{@"email":email,
                               @"password":password};
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDict
                                                       options:NSJSONWritingPrettyPrinted error:nil];
    NSString* dataString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\\" withString:@""];

    
    NSURLQueryItem* itemData = [[NSURLQueryItem alloc] initWithName:@"data" value:dataString];
    NSURLQueryItem* itemIdentifier = [[NSURLQueryItem alloc] initWithName:@"identifier" value:identifier];
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:strURL] resolvingAgainstBaseURL:NO];
    components.queryItems = @[itemIdentifier, itemData];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    
    request.URL = components.URL;
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[components percentEncodedQuery] dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        
        NSLog(@"%@", strURL);
        completeResponse(dicReponse, status);
    }];
    
    
}

#pragma mark - Users
- (void)getUsersWithIdentifier:(NSString *)idetnitfier data:(NSString *)data complete:(APIServiceResponse)completeResponse {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users",BASE_API_URL]];
    NSURLQueryItem* itemData = [[NSURLQueryItem alloc] initWithName:@"data" value:data];
    NSURLQueryItem* itemIdentifier = [[NSURLQueryItem alloc] initWithName:@"identifier" value:idetnitfier];
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithURL:URL resolvingAgainstBaseURL:NO];
    components.queryItems = @[itemIdentifier, itemData];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.HTTPMethod = @"GET";
    request.URL = components.URL;
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", request.URL);
        completeResponse(dicReponse, status);
    }];
}

#pragma mark - Chat
- (void)getChatListWithIdentifier:(NSString *)idetnitfier data:(NSString *)data complete:(APIServiceResponse)completeResponse {
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/chat_messages/chat_list",BASE_API_URL]];
    NSURLQueryItem* itemData = [[NSURLQueryItem alloc] initWithName:@"data" value:data];
    NSURLQueryItem* itemIdentifier = [[NSURLQueryItem alloc] initWithName:@"identifier" value:idetnitfier];
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithURL:URL resolvingAgainstBaseURL:NO];
    components.queryItems = @[itemIdentifier, itemData];

    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.HTTPMethod = @"GET";
    request.URL = components.URL;
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", request.URL);
        completeResponse(dicReponse, status);
    }];
    
}

-(void)getChatHistoryWithIdentifier:(NSString*)identifier
                               data:(NSString*)data
                           complete:(APIServiceResponse)completeResponse{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/chat_messages",BASE_API_URL]];
    NSURLQueryItem* itemData = [[NSURLQueryItem alloc] initWithName:@"data" value:data];
    NSURLQueryItem* itemIdentifier = [[NSURLQueryItem alloc] initWithName:@"identifier" value:identifier];
    
    NSURLComponents* components = [[NSURLComponents alloc] initWithURL:URL resolvingAgainstBaseURL:NO];
    components.queryItems = @[itemIdentifier, itemData];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.HTTPMethod = @"GET";
    request.URL = components.URL;
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [TransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, TransportResponseStatus status, NSData* data) {
        NSLog(@"%@", request.URL);
        completeResponse(dicReponse, status);
    }];

}


@end
