//
//  SearchingCell.m
//  Cryptochat
//
//  Created by Антон  Смирнов on 14.05.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "SearchingCell.h"
#import "SearchingModel.h"
#import "UIImageView+WebCache.h"

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
    if(model.photoURL){
        [_photoView sd_setImageWithURL:model.photoURL];
    }
    _nameLabel.text = model.name;
    _photoView.clipsToBounds = YES;
    _photoView.layer.cornerRadius = 22;
}

@end
