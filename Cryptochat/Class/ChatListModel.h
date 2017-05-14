//
//  ChatListModel.h
//  Cryptochat
//
//  Created by Artem Konarev on 30.04.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatListModel : NSObject

@property (strong, nonatomic) NSString* lastMessage;
@property (assign, nonatomic) BOOL isRead;
@property (assign, nonatomic) BOOL isMy;

@end
