//
//  ViewController.m
//  TableViewDelete
//
//  Created by fengpan on 2018/11/13.
//  Copyright © 2018 fengpan. All rights reserved.
//

#import "ViewController.h"
#import "DeleteCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <NSString *>*sourceArray;

@property (nonatomic, strong) NSIndexPath *editingIndexPath;

@end

@implementation ViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.editingIndexPath){
        [self configSwipeButtons];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DeleteCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([DeleteCell class])];

}

-(NSMutableArray<NSString *> *)sourceArray{
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray array];
        for (int a = 0; a<20; a++) {
            [_sourceArray addObject:[NSString stringWithFormat:@"我是第----%d个----fc",a]];
        }
    }
    return _sourceArray;
}

#pragma mark - Datasourcedelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    DeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DeleteCell class]) forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.text = self.sourceArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
/**
 *  设置删除按钮
 *
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [_sourceArray removeObjectAtIndex:indexPath.row];
        [_tableView reloadData];
    }
}
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editingIndexPath = indexPath;
    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.editingIndexPath = nil;
}

#pragma mark - configSwipeButtons
- (void)configSwipeButtons{
    // iOS 11层级 (Xcode 9编译): UITableView -> UISwipeActionPullView
    for (UIView *subview in self.tableView.subviews){
        NSLog(@"%@-----%zd",subview,subview.subviews.count);
        if ([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] &&
            [subview.subviews count] >= 1){
            // 和iOS 10的按钮顺序相反
            subview.backgroundColor = [UIColor whiteColor];
            UIButton *deleteButton = subview.subviews[0];
            [self configDeleteButton:deleteButton];
        }
    }
}
- (void)configDeleteButton:(UIButton*)deleteButton{
    if (deleteButton) {
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"bgview"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventAllTouchEvents];
        [deleteButton setBackgroundColor:[UIColor whiteColor]];
        deleteButton.frame = CGRectMake(deleteButton.frame.origin.x, 10, deleteButton.frame.size.width, deleteButton.frame.size.height - 20);
    }
}


//按钮的点击操作
- (void)deleteAction:(UIButton *)sender{
    [self.view setNeedsLayout];
    [sender setBackgroundColor:[UIColor whiteColor]];
}



@end
