//
//  ChatListCell.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 08.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatListViewModel;

@interface ChatListCell : UITableViewCell
-(void)configCell:(ChatListViewModel*)model;
@end
