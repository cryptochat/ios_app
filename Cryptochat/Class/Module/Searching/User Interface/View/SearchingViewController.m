//
//  SearchingSearchingViewController.m
//  Cryptochat
//
//  Created by nordsmallcountry on 14/05/2017.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "SearchingViewController.h"
#import "SearchingCell.h"
#import "SearchingModel.h"

static NSString* identifierCell = @"SearchingCell";
static CGFloat cell_height = 63;

@interface SearchingViewController()<UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic)IBOutlet UITableView* tableView;
@end

@implementation SearchingViewController{
    NSMutableArray<SearchingModel*>* _arrModels;
    NSMutableArray<SearchingModel*>* _searchModels;
    NSNumber *itemIndexInArray;
    BOOL shouldSearch;
}

#pragma mark - Методы жизненного цикла

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.presenter viewInit];
    [self configTable];
}

-(void)configTable{
    [_tableView registerNib:[UINib nibWithNibName:identifierCell bundle:nil] forCellReuseIdentifier:identifierCell];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setBackgroundColor:[UIColor whiteColor]];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchingCell* cell = [_tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    [cell configCell:_arrModels[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cell_height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    itemIndexInArray = [NSNumber numberWithInteger:indexPath.row];
    SearchingModel *model = [self searchItemModelFromArray];
    [self.presenter viewClickChat:@(model.index)];
}

-(SearchingModel*)searchItemModelFromArray{
    if (_arrModels.count >= [itemIndexInArray integerValue] && _arrModels.count > 0){
        return [_arrModels objectAtIndex:[itemIndexInArray integerValue]];
    }
    return nil;
}


#pragma mark - SearchingViewInterfaceOutputView <NSObject>

-(void)updateView:(NSArray<SearchingModel*>*)arrModels{
    if (_arrModels) {
        [_arrModels removeAllObjects];
    }
    _arrModels = (NSMutableArray*)arrModels;
    [_tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.presenter viewSearchUsersWithQuery:searchText];
}

@end
