//
//  SocketService.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 15.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "SocketService.h"
#import "SRWebSocket.h"

@interface SocketService()<SRWebSocketDelegate>


@end

@implementation SocketService{
    SRWebSocket *_webSocket;
    NSURL* _URLSocket;
    __weak id<SocketServiceDelegate> _delegate;

}

-(instancetype)initWithURL:(NSURL*)URL delegate:(id <SocketServiceDelegate>)delegate{
    self = [super init];
    if(self){
        _URLSocket = URL;
        _delegate = delegate;
        
        // create soket
        NSURLRequest *request = [NSURLRequest requestWithURL:_URLSocket];
        _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
        _webSocket.delegate = self;
    }
    return self;
}

-(void)sendMessage:(id)message{
    [_webSocket send:message];
}

-(void)openSocket{
    [_webSocket open];
}

-(void)closeSocket{
    [_webSocket close];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    if([_delegate respondsToSelector:@selector(chatServiceInComingMessage:)]){
        
        NSData *objectData = [message dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dicMessage = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
        
        [_delegate chatServiceInComingMessage:dicMessage];
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    if([_delegate respondsToSelector:@selector(chatServiceSocketOpenSocket)]){
        [_delegate chatServiceSocketOpenSocket];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    if([_delegate respondsToSelector:@selector(chatServiceInComingError:)]){
        [_delegate chatServiceInComingError:error];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    if([_delegate respondsToSelector:@selector(chatServiceInComingError:)]){
        [_delegate chatServiceInComingError:[NSError errorWithDomain:@"Close socket" code:0 userInfo:nil]];
    }
}


@end
