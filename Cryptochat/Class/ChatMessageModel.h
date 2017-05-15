//
//  ChatHistoryModel.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 15.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MethodType){
    MethodTypeConformation,
    MethodTypeIncoming,
};


@interface ChatMessageModel : NSObject
@property (strong, nonatomic) NSDate* createdDate;
@property (strong, nonatomic) NSString* message;
@property(strong, nonatomic)NSNumber* valueID;
@property(strong, nonatomic)NSURL* avatarURL;
@property(strong, nonatomic)NSString* userName;
@property(strong, nonatomic)NSString* firstName;
@property(strong, nonatomic)NSString* lastName;
@property(assign, nonatomic)BOOL fromMe;
@property(assign, nonatomic)BOOL isOnline;

@property(assign, nonatomic)MethodType methodType;
@end
