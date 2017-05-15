//
//  MessageViewModel.h
//  Cryptochat
//
//  Created by Artem Konarev on 15.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MessageType){
    MessageTypeText,
    MessageTypeImage,
    MessageTypeTyping
};

typedef NS_ENUM(NSUInteger, AuthorType){
    AuthorTypeMy,
    AuthorTypeNotMy
};


@interface MessageViewModel : NSObject

@property (strong, nonatomic) NSURL *userURLAvatar;
@property (strong, nonatomic) NSNumber *userID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userFirstName;
@property (strong, nonatomic) NSString *userLastName;
@property (strong, nonatomic) NSString *messageText;
@property (strong, nonatomic) NSString *date;
@property (assign, nonatomic) MessageType messageType;
@property (assign, nonatomic) AuthorType authorType;
@property BOOL isOnline;
@property BOOL isSeccussSent;

- (BOOL)isEqualToMessage:(MessageViewModel *)message;
@end
