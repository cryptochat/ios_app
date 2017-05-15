//
//  SocketService.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 15.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "SocketService.h"
#import "SRWebSocket.h"
#import "ChatMessageModel.h"

@interface SocketService()<SRWebSocketDelegate>

@end

@implementation SocketService{
    SRWebSocket *_webSocket;
    NSURL* _URLSocket;
    __weak id<SocketServiceDelegate> _delegate;
    NSString* _identifier;

}

-(instancetype)initWithURL:(NSURL*)URL delegate:(id <SocketServiceDelegate>)delegate identifier:(NSString*)identifier{
    self = [super init];
    if(self){
        _URLSocket = URL;
        _identifier = identifier;
        _delegate = delegate;
        
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
       
        NSString* type = dicMessage[@"type"];
        if([type isEqualToString:@"confirm_subscription"]){
            //Успешно подписались на канал для обмена сообщениями
            if([_delegate respondsToSelector:@selector(isSuccessSubscribed)]){
                [_delegate isSuccessSubscribed];
            }
        }
        
        NSLog(@"%@", dicMessage);
        if(dicMessage[@"identifier"] && dicMessage[@"message"]){
            [_delegate chatServiceInComingMessage:dicMessage];
        }
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    if([_delegate respondsToSelector:@selector(chatServiceSocketOpenSocket)]){
        [_delegate chatServiceSocketOpenSocket];
         [self sendMessageForSubscribing];
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


#pragma private
-(void)sendMessageForSubscribing{
    NSDictionary *jsonDictionary = @{@"command":@"subscribe", @"identifier":@"{\"channel\":\"WsChatChannel\"}"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString* dataString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    [_webSocket send:dataString];
}




@end
