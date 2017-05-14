//
//  UserService.m
//  Cryptochat
//
//  Created by Artem Konarev on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "UserService.h"
#import "Base64Coder.h"
#import "KeyChainService.h"
#import "UserAuthModel.h"
#import "UserParser.h"

@interface UserService()

@property (strong, nonatomic) ServiceAPI* serviceAPI;
@property (strong, nonatomic) Base64Coder* base64Coder;
@property (strong, nonatomic) KeyChainService* keyChainService;
@property (strong, nonatomic) UserParser* userParser;

@end


@implementation UserService

-(instancetype)init{
    self = [super init];
    if(self){
        self.serviceAPI = [ServiceAPI new];
        self.base64Coder = [Base64Coder new];
        self.keyChainService = [KeyChainService new];
        self.userParser = [UserParser new];
    }
    return self;
}


- (void)getUsersWithToken:(NSString *)token
                    query:(NSString *)query
                 complete:(void (^)(TransportResponseStatus status, NSArray<InterlocutorModel *> *userArray))completeResponse {
    NSString *identidier = [self.keyChainService getIdentifier];
    
    NSDictionary *jsonDictionary;
    if (query) {
        jsonDictionary = @{@"token" : token,
                           @"query" : query};
 
    } else {
         jsonDictionary = @{@"token" : token};
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString* dataString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    dataString = [dataString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    //NSString *base64Data = [self.base64Coder encodedStringFromBase64Data:jsonData];
    
    [self.serviceAPI getUsersWithIdentifier:identidier data:dataString complete:^(NSDictionary *dicReponse, TransportResponseStatus status) {
        
        if (status != TransportResponseStatusSuccess) {
            completeResponse (status, nil);
            return;
        }
        NSArray *interlocutorModelsArray = [self.userParser createInterlocutorModelsArrayFromDictionary:dicReponse];
        
        completeResponse (status, interlocutorModelsArray);
    }];

}

@end
