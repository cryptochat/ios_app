//
//  BubbleTextCell.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "BubbleTextCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

const CGFloat BubbleWidthOffsetText = 30.0f;
const CGFloat BubbleImageSizeText = 40.0f;
const CGFloat AvatarImageOffsetXText = 10.0f;
const CGFloat AvatarImageOffsetYText = 10.0f;

@implementation BubbleTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.bubbleView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.bubbleView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:self.bubbleView];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.font = [UIFont systemFontOfSize:15.f];
        
        self.avatarImageView = [UIImageView new];
        [self.avatarImageView setFrame:CGRectMake(AvatarImageOffsetX, 2*AvatarImageOffsetY, BubbleImageSize, BubbleImageSize)];
        self.avatarImageView.layer.cornerRadius = CGRectGetWidth(self.avatarImageView.frame)/2;
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.image = [UIImage imageNamed:@"photo_test"];
        self.avatarImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.avatarImageView];
        
        self.dateLabel = [UILabel new];
        self.dateLabel.textColor = [UIColor lightGrayColor];
        self.dateLabel.font = [UIFont systemFontOfSize:9.f];
        [self.contentView addSubview:self.dateLabel];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.textColor = [UIColor lightGrayColor];
        self.nameLabel.font = [UIFont systemFontOfSize:9.f];
        [self.contentView addSubview:self.nameLabel];
        
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self.bubbleView addGestureRecognizer:longPressRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.imageView addGestureRecognizer:tapRecognizer];
        UITapGestureRecognizer *tapAvatarRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnAvatar:)];
        [self.avatarImageView addGestureRecognizer:tapAvatarRecognizer];
        
        
        // Defaults
        self.canCopyContents = YES;
        self.selectionAdjustsColor = YES;
    }
    
    return self;
}

-(void)updateMessage:(MessageViewModel *)message{
    self.isSuccessSend = message.isSeccussSent;
    self.authorType = message.authorType;
    self.textLabel.text = message.messageText;
    self.dateLabel.text = message.date;
    self.nameLabel.text = message.userFirstName;
    __weak BubbleTextCell *weakself = self;
    [self.avatarImageView sd_setImageWithURL:message.userURLAvatar placeholderImage:[UIImage imageNamed:@"photo_test"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(error){
            weakself.avatarImageView.image = [UIImage imageNamed:@"photo_test"];
        }else{
            weakself.avatarImageView.image = image;
        }
    }];
    
}

- (void)updateFramesForAuthorType:(AuthorType)type
{
    
    CGFloat minInset = 0.0f;
    if([self.dataSource respondsToSelector:@selector(minInsetForCell:atIndexPath:)])
    {
        minInset = [self.dataSource minInsetForCell:self atIndexPath:[[self tableView] indexPathForCell:self]];
    }
    
    CGSize size;
    
    size = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width - minInset - BubbleWidthOffset, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]}
                                             context:nil].size;
    
    if(type == AuthorTypeMy){
        self.textLabel.textColor = [UIColor whiteColor];
        
        [self.avatarImageView setHidden:YES];
        
        self.bubbleView.image = [[UIImage imageNamed:@"bubble_blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 10.0f, 10.0f, 10.0f)];
        self.bubbleView.frame = CGRectMake(self.frame.size.width - (size.width) - BubbleImageSize - 8.0f, 2*AvatarImageOffsetY, size.width + BubbleWidthOffset, size.height + 15.0f);
        
        self.textLabel.frame = CGRectMake(self.frame.size.width - (size.width + BubbleWidthOffset - 5.0f) - BubbleImageSize - 8.0f, self.frame.size.height - (size.height + 15.0f) + 6.0f, size.width + BubbleWidthOffset - 23.0f, size.height);
        self.textLabel.center = self.bubbleView.center;
        
        self.bubbleView.transform = CGAffineTransformIdentity;
        
        [self.dateLabel setFrame:CGRectMake(0, self.bubbleView.frame.size.height/2 + 10, self.frame.size.width - self.bubbleView.frame.size.width - 25, 20)];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        return;
    }
    
    if(type == AuthorTypeNotMy){
        self.textLabel.textColor = [UIColor whiteColor];
        
        self.bubbleView.image = [[UIImage imageNamed:@"bubble_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 10.0f, 10.0f, 10.0f)];
        self.bubbleView.frame = CGRectMake(BubbleWidthOffset + 3*AvatarImageOffsetX, 2*AvatarImageOffsetY, size.width + BubbleWidthOffset, size.height + 15.0f);
        self.textLabel.frame = CGRectMake(BubbleWidthOffset + 4*AvatarImageOffsetX, 3*AvatarImageOffsetY, size.width + BubbleWidthOffset - 23.0f, size.height);
        self.textLabel.center = self.bubbleView.center;
        
        self.bubbleView.transform = CGAffineTransformIdentity;
        
        [self.avatarImageView setFrame:CGRectMake(AvatarImageOffsetX, self.bubbleView.frame.size.height - BubbleImageSize/2, BubbleImageSize, BubbleImageSize)];
        
        [self.dateLabel setFrame:CGRectMake(self.bubbleView.frame.origin.x + self.bubbleView.frame.size.width + 5, self.bubbleView.frame.size.height/2 + 10, 50, 20)];
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.nameLabel setFrame:CGRectMake(AvatarImageOffsetX, self.bubbleView.frame.size.height + 20.0f, self.bubbleView.frame.size.width, 20)];
        
        return;
    }
}


- (void)layoutSubviews
{
    [self updateFramesForAuthorType:self.authorType];
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    
    while(tableView)
    {
        if([tableView isKindOfClass:[UITableView class]])
        {
            return (UITableView *)tableView;
        }
        
        tableView = tableView.superview;
    }
    
    return nil;
}

#pragma mark - UIGestureRecognizer methods

- (void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if(self.canCopyContents)
        {
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            [self becomeFirstResponder];
            [menuController setTargetRect:self.bubbleView.frame inView:self];
            [menuController setMenuVisible:YES animated:YES];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideMenuController:) name:UIMenuControllerWillHideMenuNotification object:nil];
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)gestureRecognizer
{
    if([self.delegate respondsToSelector:@selector(tappedImageOfCell:atIndexPath:)])
    {
        [self.delegate tappedImageOfCell:self atIndexPath:[[self tableView] indexPathForCell:self]];
    }
}

#pragma mark - UIMenuController methods

- (BOOL)canPerformAction:(SEL)selector withSender:(id)sender
{
    if(selector == @selector(copy:))
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:self.textLabel.text];
}

- (void)willHideMenuController:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}


- (void)tapOnAvatar:(UITapGestureRecognizer *)gestureRecognizer{
    if([self.delegate respondsToSelector:@selector(tappedOnAvatar:atIndexPath:)])
    {
        [self.delegate tappedOnAvatar:self atIndexPath:[[self tableView] indexPathForCell:self]];
    }
}



@end
