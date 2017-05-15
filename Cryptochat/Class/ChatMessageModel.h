//
//  ChatHistoryModel.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 15.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ChatMessageModel : NSObject
@property (strong, nonatomic) NSDate* createdDate;
@property (strong, nonatomic) NSString* message;
@property(strong, nonatomic)NSNumber* valueID;

@end
