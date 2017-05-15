//
//  ChatService.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ChatService.h"
#import "Base64Coder.h"
#import "KeyChainService.h"
#import "RealmDataStore.h"
#import "UserAuthModel.h"
#import "ChatParser.h"
#import "ChatMessageModel.h"
#import "SocketService.h"


@interface ChatService()<SocketServiceDelegate>
@property (strong, nonatomic) ServiceAPI* serviceAPI;
@property (strong, nonatomic) Base64Coder* base64Coder;
@property (strong, nonatomic) KeyChainService* keyChainService;
@property (strong, nonatomic) RealmDataStore* realmDataStore;
@property (strong, nonatomic) ChatParser* chatParser;
@property(strong, nonatomic)SocketService* socketService;
@end


@implementation ChatService

-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.base64Coder = [Base64Coder new];
        self.keyChainService = [KeyChainService new];
        self.realmDataStore = [RealmDataStore new];
        self.chatParser = [ChatParser new];
    }
    return self;
}

- (void)getChatListWithToken:(NSString *)token
                    complete:(void (^)(TransportResponseStatus status, NSArray<InterlocutorModel *> *userArray, NSArray<ChatListModel *> *chatLustArray))completeResponse {
    
    NSString *identidier = [self.keyChainService getIdentifier];
    
    UserAuthModel *model = [self.realmDataStore getUser];
    NSDictionary *jsonDictionary = @{@"token" : model.token};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
   
    NSString* dataString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    //NSString *base64Data = [self.base64Coder encodedStringFromBase64Data:jsonData];
    
    [self.serviceAPI getChatListWithIdentifier:identidier data:dataString complete:^(NSDictionary *dicReponse, TransportResponseStatus status) {
    
        if (status != TransportResponseStatusSuccess) {
            completeResponse (status, nil, nil);
            return;
        }
        NSArray *interlocutorModelsArray = [self.chatParser createInterlocutorModelsArrayFromDictionary:dicReponse];
        NSArray *chatListModelsArray = [self.chatParser createChatListModelsArrayFromDictionary:dicReponse];
            
        completeResponse (status, interlocutorModelsArray, chatListModelsArray);
    }];
}


-(void)getChatHistoryWithID:(NSString*)interlocutorID
                      limit:(int)limit
                     offset:(int)offset
                   complete:(void(^)(TransportResponseStatus status, NSArray<ChatMessageModel*>* arrHistory))complete{
    NSString *identidier = [self.keyChainService getIdentifier];
    
    UserAuthModel *model = [self.realmDataStore getUser];
    NSDictionary *jsonDictionary = @{@"token" : model.token,
                                     @"interlocutor_id": interlocutorID,
                                     @"limit": [NSString stringWithFormat:@"%d",limit],
                                     @"offset" : [NSString stringWithFormat:@"%d", offset]};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* dataString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    [_serviceAPI getChatHistoryWithIdentifier:identidier data:dataString complete:^(NSDictionary *dicReponse, TransportResponseStatus status) {
         if (status != TransportResponseStatusSuccess) {
             complete(status, nil);
             return;
         }
        NSArray* historyArr = [self.chatParser createChatHistoryFromDict:dicReponse];
        complete(status, historyArr);
        
    }];
}


#pragma mark - Socket

-(void)startConfigChat{
    UserAuthModel* user = [_realmDataStore getUser];
    NSString *identidier = [self.keyChainService getIdentifier];
    
    NSString* stringURL = [NSString stringWithFormat:@"ws://wishbyte.org/cable?identifier=%@&token=%@",identidier, user.token];
    NSURL* socketURL = [[NSURL alloc]initWithString:stringURL];
    _socketService = [[SocketService alloc]initWithURL:socketURL delegate:self];
    [_socketService openSocket];
}

-(void)chatServiceSocketOpenSocket{
    
}
-(void)chatServiceSocketCloseSocket{
    
}
-(void)chatServiceInComingMessage:(NSDictionary*)message{
    
}
-(void)chatServiceInComingError:(NSError*)error{
    
}

@end
