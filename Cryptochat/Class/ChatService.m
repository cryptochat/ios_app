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

@interface ChatService()
@property (strong, nonatomic) ServiceAPI* serviceAPI;
@property (strong, nonatomic) Base64Coder* base64Coder;
@property (strong, nonatomic) KeyChainService* keyChainService;
@end


@implementation ChatService

-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.base64Coder = [Base64Coder new];
        self.keyChainService = [KeyChainService new];
    }
    return self;
}

- (void)getChatListWithToken:(NSString *)token
                    complete:(void (^)(TransportResponseStatus status, NSArray<UserModel *> *userArray, NSArray<ChatListModel *> *chatLustArray))completeResponse {
    
    NSString *identidier = [self.keyChainService getIdentifier];
    NSDictionary *jsonDictionary = @{@"token" : token,};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *base64Data = [self.base64Coder encodedStringFromBase64Data:jsonData];
    
    [self.serviceAPI getChatListWithIdentifier:identidier data:base64Data complete:^(NSDictionary *dicReponse, TransportResponseStatus status) {
    
        if (status != TransportResponseStatusSuccess) {
            completeResponse (status, nil, nil);
        } else {
            
        }
        
    }];
}

@end
