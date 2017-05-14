//
//  ChatListViewModel.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 08.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatListViewModel : NSObject
@property(strong, nonatomic)NSString* name;
@property(strong, nonatomic)NSData* photoData;
@property(strong, nonatomic)NSString* lastMessage;
@property(assign, nonatomic)BOOL isReaded;
@property(assign, nonatomic)BOOL isOnline;
@property(strong, nonatomic)NSString* stringDate;
@end
