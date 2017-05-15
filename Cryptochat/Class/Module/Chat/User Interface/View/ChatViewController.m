//
//  ChatChatViewController.m
//  Cryptochat
//
//  Created by Artem on 15/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageViewModel.h"
#import "ChatBubbleCell.h"
#import "UIScrollView+InfiniteScroll.h"

@interface ChatViewController ()<UITextFieldDelegate, BubbleViewCellDataSource, BubbleViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UIView *viewNotItems;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageViewConstraintBottom;

@property (nonatomic, strong) NSMutableArray<MessageViewModel*> *messagesArray;

@end

static NSString* identifierCell = @"BubbleCell";

@implementation ChatViewController {
    UIRefreshControl *_refreshControl;
    NSString *messageStr;
    CGFloat cellSizeHeight;
    NSInteger oldArrayCount;
    BOOL isRefresh;
}

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configNavigationController];
    [self configTable];
    [self configMessageField];
    [self configButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    self.messagesArray = [NSMutableArray new];
    [self.presenter viewInit];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void)configNavigationController{
    self.navigationItem.title = @"Чат";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};

    [self setNeedsStatusBarAppearanceUpdate];
}


-(void)configTable{
    self.chatTableView.tableFooterView = [UIView new];
    self.chatTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.chatTableView.transform = CGAffineTransformMakeRotation(-M_PI);
    __weak ChatViewController *weakself = self;
    [weakself.chatTableView addInfiniteScrollWithHandler:^( UITableView* tableView) {
        oldArrayCount = weakself.messagesArray.count;
        [weakself.presenter viewDownloadNewMessagesWithOffset:@(weakself.messagesArray.count)];
    }];
    [self addRefreshControl];
}

-(void)configMessageField{
    [self.messageTextField setDelegate:self];
    [self.messageTextField setFont:[UIFont systemFontOfSize:15.f]];
}

- (void)configButton {
    self.sendButton.layer.cornerRadius = 6;
    self.sendButton.clipsToBounds = YES;
}

-(void)addRefreshControl{
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(handlerRefresh) forControlEvents:UIControlEventValueChanged];
    isRefresh = true;
    [self.chatTableView addSubview:_refreshControl];
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.chatTableView setContentOffset:CGPointZero animated:NO];
    messageStr = textField.text;
}

#pragma mark - BubbleViewCellDataSource

- (CGFloat)minInsetForCell:(ChatBubbleCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

#pragma mark - BubbleViewCellDelegate
- (void)cellSizeHeight:(CGFloat)cellHeight {
    cellSizeHeight = cellHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messagesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageViewModel *message = [self.messagesArray objectAtIndex:indexPath.row];
    ChatBubbleCell *cell = (ChatBubbleCell *)[tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [ChatBubbleCell new];
    }
    cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell andMessageType:message.messageType];
    cell.dataSource = self;
    cell.delegate = self;
    [cell updateMessage:message];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageViewModel *message = [self.messagesArray objectAtIndex:indexPath.row];
    
    CGSize size;
    if (message.messageType == MessageTypeText) {
        size = [message.messageText boundingRectWithSize:CGSizeMake(self.chatTableView.frame.size.width - [self minInsetForCell:nil atIndexPath:indexPath] - BubbleWidthOffset, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]}
                                                 context:nil].size;
        
        size.height = size.height + 40.f;
    }
    
    return size.height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.transform = CGAffineTransformMakeRotation(M_PI);
    cell.backgroundColor = self.chatTableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}



#pragma mark - ChatViewInterfaceOutputView <NSObject>
- (void)showDisplayMessages:(NSArray<MessageViewModel *> *)messages{
    if([self checkArraysOnEmpty:messages]){
        [self showViewNotItems];
        return;
    }
    [self hideViewNotItems];
    
    if(_refreshControl.isRefreshing) {
        [self updateChatTableFronArray:messages];
        [_refreshControl endRefreshing];
        return;
    }
    [self instertItemArray:messages];
    [self.chatTableView finishInfiniteScrollWithCompletion:nil];
}

- (void)showDisplayNewMessages:(NSArray<MessageViewModel *> *)messages {
    [self hideViewNotItems];
    [self updateChatTableFronArray:messages];
    [self.chatTableView reloadData];
    [self scrollToLastMessage];
}

- (void)updateChatTableFronArray:(NSArray<MessageViewModel *> *)messages {
    NSMutableArray *bufArray = [NSMutableArray new];
    [bufArray addObjectsFromArray:self.messagesArray];
    [self.messagesArray removeAllObjects];
    [self.messagesArray addObjectsFromArray:messages];
    [self.messagesArray addObjectsFromArray:bufArray];
    [self.chatTableView reloadData];
}

-(void)showConfirmSendMessage:(MessageViewModel*)message{
    for (MessageViewModel *messModel in self.messagesArray) {
        if ([message isEqualToMessage:messModel]) {
            messModel.isSeccussSent = message.isSeccussSent;
            [_chatTableView reloadData];
        }
    }
}


#pragma mark - refresh
- (void)handlerRefresh {
    oldArrayCount = self.messagesArray.count;
    [self.presenter viewDownloadNewMessagesWithOffset:@(self.messagesArray.count)];
}

- (void)instertItemArray:(NSArray*)arrayNewIntem {
    NSMutableArray* arrayNewIndex = [NSMutableArray new];
    for(int i = (int)self.messagesArray.count; i < self.messagesArray.count + arrayNewIntem.count; i++)
    {
        [arrayNewIndex addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [self.messagesArray addObjectsFromArray:arrayNewIntem];
    [self.chatTableView insertRowsAtIndexPaths:arrayNewIndex withRowAnimation:UITableViewRowAnimationNone];
    [self performSelector:@selector(scrollToLastMessage) withObject:nil afterDelay:0.1];

}

- (BOOL)checkArraysOnEmpty:(NSArray<MessageViewModel*>*)arrayItems {
    return (self.messagesArray.count == 0 && arrayItems.count == 0);
}

- (void)refreshTable {
    [self.chatTableView reloadData];
}

- (void)showViewNotItems {
    self.viewNotItems.hidden = false;
    self.chatTableView.hidden = true;
}

- (void)hideViewNotItems {
    self.viewNotItems.hidden = true;
    self.chatTableView.hidden = false;
}


#pragma mark - keyboardWasShown
- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.messageViewConstraintBottom.constant += keyboardInfoFrame.size.height;
    [self performSelector:@selector(scrollToLastMessage) withObject:nil afterDelay:0.1];
}

#pragma mark - keyboardWillBeHidden
- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.messageViewConstraintBottom.constant -= keyboardInfoFrame.size.height;
    
}

#pragma mark - dismissKeyboard
- (void)dismissKeyboard {
    [self.messageTextField resignFirstResponder];
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

#pragma mark - scroll
- (void)scrollToLastMessage {
    if(self.messagesArray.count > 0){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_chatTableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }
}


@end
