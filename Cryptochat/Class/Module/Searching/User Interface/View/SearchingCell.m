//
//  SearchingCell.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "SearchingCell.h"
#import "SearchingModel.h"

@interface SearchingCell()
@property(weak, nonatomic)IBOutlet UIImageView* photoView;
@property(weak, nonatomic)IBOutlet UILabel* nameLabel;
@end

@implementation SearchingCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configCell:(SearchingModel*)model{
    //_photoView.image = [UIImage imageWithData:model.photoData];
    _nameLabel.text = model.name;
    _photoView.layer.cornerRadius = 30;
}

@end
