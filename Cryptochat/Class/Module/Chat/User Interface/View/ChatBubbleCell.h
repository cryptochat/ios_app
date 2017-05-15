//
//  ChatBubbleCell.h
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewModel.h"


@protocol BubbleViewCellDataSource, BubbleViewCellDelegate;

extern const CGFloat BubbleWidthOffsetText;
extern const CGFloat BubbleImageSizeText;
extern const CGFloat AvatarImageOffsetXText;
extern const CGFloat AvatarImageOffsetYText;

extern const CGFloat BubbleWidthOffset;
extern const CGFloat BubbleImageSize;
extern const CGFloat AvatarImageOffsetX;
extern const CGFloat AvatarImageOffsetY;

@interface ChatBubbleCell : UITableViewCell
@property (strong, nonatomic) UIImageView *bubbleView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIImage *messageImage;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (nonatomic, assign) AuthorType authorType;
@property (nonatomic, assign) MessageType messageType;
@property (nonatomic, assign) BOOL isSuccessSend;
@property (nonatomic, assign) BOOL canCopyContents; // Defaults to YES
@property (nonatomic, assign) BOOL selectionAdjustsColor; // Defaults to YES
@property (nonatomic, weak) id <BubbleViewCellDataSource> dataSource;
@property (nonatomic, weak) id <BubbleViewCellDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier
               andMessageType:(MessageType)messageType;

- (void)updateFramesForAuthorType:(AuthorType)type;
- (void)layoutSubviews;
- (UITableView *)tableView;
- (void)updateAuthorType:(AuthorType)type;
- (void)updateAvatar:(NSURL*)urlAvatar;
- (void)updateMessage:(MessageViewModel*)message;

@end

@protocol BubbleViewCellDataSource <NSObject>
@optional
- (CGFloat)minInsetForCell:(ChatBubbleCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@protocol BubbleViewCellDelegate <NSObject>
@optional
- (void)tappedImageOfCell:(ChatBubbleCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)tappedOnAvatar:(ChatBubbleCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)cellSizeHeight:(CGFloat)cellHeight;
@end
