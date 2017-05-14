//
//  ChatService.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ChatService.h"
#import "ServiceAPI.h"
#import "Base64Coder.h"
#import "KeyChainService.h"
#import "RealmDataStore.h"
#import "UserAuthModel.h"
#import "ChatParser.h"

@interface ChatService()
@property (strong, nonatomic) ServiceAPI* serviceAPI;
@property (strong, nonatomic) Base64Coder* base64Coder;
@property (strong, nonatomic) KeyChainService* keyChainService;
@property (strong, nonatomic) RealmDataStore* realmDataStore;
@property (strong, nonatomic) ChatParser* chatParser;
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
        } else {
            NSArray *interlocutorModelsArray = [self.chatParser createInterlocutorModelsArrayFromDictionary:dicReponse];
        }
        
    }];
}

@end
