//
//  ChatListChatListViewController.m
//  Cryptochat
//
//  Created by nordsmallcountry on 08/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatListViewModel.h"
#import "ChatListCell.h"


static NSString* NAV_BAR_TITLE = @"Список чатов";
static NSString* identifierCell = @"ChatListCell";
static float CELL_HEIGHT = 80;

@interface ChatListViewController()<UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic)IBOutlet UITableView* tableView;
@property (strong, nonatomic) UISearchController *controller;

@end

@implementation ChatListViewController{
    NSArray<ChatListViewModel*>* _arrModels;
}

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.presenter viewInit];
        [self configTable];
    });
   
}

-(void)viewWillAppear:(BOOL)animated{
    [self configNavigationBar];
}

-(void)configNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:17]}];
    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Список чатов";
    
    //UIBarButtonItem* itemForward = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_menu_close"] style:UIBarButtonItemStylePlain target:self action:@selector(onForward)];
    UIBarButtonItem* itemForward = [[UIBarButtonItem alloc]initWithTitle:@"Поиск" style:UIBarButtonItemStylePlain target:self action:@selector(onForward)];
    itemForward.tintColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = itemForward;
    
    
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
//    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

-(void)onForward{
    [self.navigationController setNavigationBarHidden: YES animated:YES];
    [self.presenter presentSearching];
}

-(void)configTable{
    [_tableView registerNib:[UINib nibWithNibName:identifierCell bundle:nil] forCellReuseIdentifier:identifierCell];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrModels.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatListCell* cell = [_tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    
    [cell configCell:_arrModels[indexPath.row]];
    return cell;
}



#pragma mark - ChatListViewInterfaceOutputView <NSObject>


-(void)updateView:(NSArray<ChatListViewModel*>*)arrModels{
    _arrModels = arrModels;
    [_tableView reloadData];
}

-(void)showAlertMessage:(NSString *)message{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
