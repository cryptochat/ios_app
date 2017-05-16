//
//  ChatParser.m
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ChatParser.h"
#import "InterlocutorModel.h"
#import "ChatListModel.h"
#import "ChatMessageModel.h"

static NSString *NullString = @"null";

@implementation ChatParser

- (NSArray<InterlocutorModel *> *) createInterlocutorModelsArrayFromDictionary:(NSDictionary *)dictionary {
    if(dictionary == nil){
        return nil;
    }
    
    NSDictionary *dicChats = dictionary[@"cipher_message"];
    NSMutableArray *bufArray = [NSMutableArray new];
    
    for (NSDictionary *bufDic in dicChats[@"chats"]) {
        InterlocutorModel *model = [InterlocutorModel new];
        
        model.interlocutorID = bufDic[@"interlocutor"][@"id"];
        model.interlocutorUsername = bufDic[@"interlocutor"][@"username"];
        model.interlocutorFirstName = bufDic[@"interlocutor"][@"first_name"];
        model.interlocutorLastName = bufDic[@"interlocutor"][@"last_name"];
        model.isOnline =  [bufDic[@"interlocutor"][@"is_online"] boolValue] ? YES : NO;
        model.valueID = [bufDic[@"interlocutor"][@"id"] isEqual:[NSNull null]] ? @(0) : bufDic[@"interlocutor"][@"id"];
        
        NSDictionary *dicAvatar = bufDic[@"interlocutor"][@"avatar"];
        model.interlocutorURLAvatar = [dicAvatar[@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"url"]]);
        model.interlocutorURLAvatarBig = [dicAvatar[@"big"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"big"][@"url"]]);
        model.interlocutorURLAvatarMedium = [dicAvatar[@"medium"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"medium"][@"url"]]);
        model.interlocutorURLAvatarSmall = [dicAvatar[@"small"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"small"][@"url"]]);
        
       
        [bufArray addObject:model];
    }

    return [NSArray arrayWithArray:bufArray];
}

- (NSArray<ChatListModel *> *) createChatListModelsArrayFromDictionary:(NSDictionary *)dictionary {
    if(dictionary == nil){
        return nil;
    }
    
    NSDictionary *dicChats = dictionary[@"cipher_message"];
    NSMutableArray *bufArray = [NSMutableArray new];
    
    for (NSDictionary *bufDic in dicChats[@"chats"]) {
        ChatListModel *model = [ChatListModel new];
        
        model.isMy = [bufDic[@"from_me"] boolValue] ? YES : NO;
        model.isRead = [bufDic[@"is_read"] boolValue] ? YES : NO;
        model.lastMessage = bufDic[@"last_message"];
        
        NSString* takeOffTime = bufDic[@"created_at"];
        model.valueID = [bufDic[@"interlocutor"][@"id"] isEqual:[NSNull null]] ? @(0) : bufDic[@"interlocutor"][@"id"];
        double miliSec = takeOffTime.doubleValue;
        model.createdDate = [NSDate dateWithTimeIntervalSince1970:miliSec];
        
        NSDictionary *dicAvatar = bufDic[@"interlocutor"][@"avatar"];
        model.URLAvatar = [dicAvatar[@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"url"]]);
        model.URLAvatarBig = [dicAvatar[@"big"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"big"][@"url"]]);
        model.URLAvatarMedium = [dicAvatar[@"medium"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"medium"][@"url"]]);
        model.URLAvatarSmall = [dicAvatar[@"small"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dicAvatar[@"small"][@"url"]]);
        
        [bufArray addObject:model];
    }
    
    return [NSArray arrayWithArray:bufArray];
}

-(NSArray<ChatMessageModel*>*)createChatHistoryFromDict:(NSDictionary*)dicResponse{
    if(dicResponse == nil){
        return nil;
    }
    NSMutableArray *bufArray = [NSMutableArray new];
    
    for(NSDictionary* dict in dicResponse[@"cipher_message"][@"messages"]){
        
        ChatMessageModel* model = [ChatMessageModel new];
        model.message = dict[@"message"][@"text"];
        NSString* takeOffTime = dict[@"message"][@"created_at"];
        double miliSec = takeOffTime.doubleValue;
        model.createdDate = [NSDate dateWithTimeIntervalSince1970:miliSec];
        model.fromMe = [dict[@"message"][@"from_me"] boolValue] ? YES : NO;
        
        
        NSDictionary* user = dict[@"user"];
        model.isOnline = [user[@"is_online"] boolValue] ? YES : NO;
        model.avatarURL = [user[@"avatar"][@"medium"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:user[@"avatar"][@"medium"][@"url"]]);
        model.firstName = user[@"first_name"];
        model.lastName = user[@"last_name"];
        model.userName = user[@"username"];
        model.valueID = [user[@"id"] isEqual:[NSNull null]] ? @(0) : user[@"id"];
        
        
        [bufArray addObject:model];
    }
    return bufArray;
}

-(ChatMessageModel*)createChatMessageFromDict:(NSDictionary*)dicResponse{
    NSString *jsonString = [NSString stringWithFormat:@"%@", dicResponse[@"message"]];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary* dict = jsonDict[@"body"];
  
    NSString* takeOffTime = dict[@"created_at"];
    double miliSec = takeOffTime.doubleValue;
    
    ChatMessageModel* model = [ChatMessageModel new];
    model.createdDate = [NSDate dateWithTimeIntervalSince1970:miliSec];
    
    //аватар
    model.avatarURL = [dict[@"sender"][@"avatar"][@"medium"][@"url"] isEqual:[NSNull null]] ? (nil) : ([NSURL URLWithString:dict[@"sender"][@"avatar"][@"medium"][@"url"]]);
    model.firstName = dict[@"sender"][@"first_name"];
    model.valueID = [dict[@"sender"][@"id"] isEqual:[NSNull null]] ? @(0) : dict[@"sender"][@"id"];
    model.lastName = dict[@"sender"][@"last_name"];
    model.userName = dict[@"sender"][@"username"];
    model.message = dict[@"text"];

    
    NSString* methodName = jsonDict[@"header"][@"method_name"];
    if([methodName isEqualToString:@"confirmation_message"]){
        model.methodType = MethodTypeConformation;
    }
    
    if([methodName isEqualToString:@"incoming_message"]){
        model.methodType = MethodTypeIncoming;
    }
    
    return model;
}

@end
