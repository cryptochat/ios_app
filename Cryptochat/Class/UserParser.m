//
//  UserParser.m
//  Cryptochat
//
//  Created by Artem Konarev on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "UserParser.h"
#import "InterlocutorModel.h"

@implementation UserParser

- (NSArray<InterlocutorModel *> *) createInterlocutorModelsArrayFromDictionary:(NSDictionary *)dictionary {
    if(dictionary == nil){
        return nil;
    }
    
    NSDictionary *dicUsers = dictionary[@"cipher_message"];
    NSMutableArray *bufArray = [NSMutableArray new];
    
    for (NSDictionary *bufDic in dicUsers[@"users"]) {
        InterlocutorModel *model = [InterlocutorModel new];
        
        model.interlocutorID = bufDic[@"id"];
        model.valueID = bufDic[@"id"];
        model.interlocutorUsername = bufDic[@"username"];
        model.interlocutorFirstName = bufDic[@"first_name"];
        model.interlocutorLastName = bufDic[@"last_name"];
        
        NSDictionary *dicAvatar = bufDic[@"avatar"];
        model.interlocutorURLAvatar = [dicAvatar[@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"url"]]);
        model.interlocutorURLAvatarBig = [dicAvatar[@"big"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"big"][@"url"]]);
        model.interlocutorURLAvatarMedium = [dicAvatar[@"medium"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"medium"][@"url"]]);
        model.interlocutorURLAvatarSmall = [dicAvatar[@"small"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"small"][@"url"]]);
        
        [bufArray addObject:model];
    }
    
    return [NSArray arrayWithArray:bufArray];

}

@end
