//
//  ChatListCell.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 08.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ChatListCell.h"
#import "ChatListViewModel.h"

@interface ChatListCell()
@property(weak, nonatomic)IBOutlet UIImageView* photoView;
@property(weak, nonatomic)IBOutlet UIImageView* isReadedView;
@property(weak, nonatomic)IBOutlet UILabel* nameLabel;
@property(weak, nonatomic)IBOutlet UILabel* lastMessageLabel;
@property(weak, nonatomic)IBOutlet UILabel* dateLabel;

@end

@implementation ChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configCell:(ChatListViewModel*)model{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _photoView.image = [UIImage imageWithData:model.photoData];
    _nameLabel.text = model.name;
    _dateLabel.text = model.stringDate;
    _lastMessageLabel.text = model.lastMessage;
    if(model.isReaded){
        
    }

}

@end
