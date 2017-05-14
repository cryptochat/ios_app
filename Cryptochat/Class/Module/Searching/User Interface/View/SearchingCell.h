//
//  SearchingCell.h
//  Cryptochat
//
//  Created by Антон  Смирнов on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchingModel;

@interface SearchingCell : UITableViewCell
-(void)configCell:(SearchingModel*)model;
@end
