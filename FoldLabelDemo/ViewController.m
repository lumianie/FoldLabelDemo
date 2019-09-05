//
//  ViewController.m
//  FoldLabelDemo
//
//  Created by Lee on 2019/9/1.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "ViewController.h"
#import "FoldLabelCell.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FoldLabelCell class]) bundle:nil
                                 ] forCellReuseIdentifier: NSStringFromClass([FoldLabelCell class])];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.modelArray = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *titleArray = @[@"【字母哥半场10分6篮板，正负值达+17】",
                            @"八村垒15分7篮板，正负值-20全场最低",
                            @"奥斯曼：每个人都为胜利做出了贡献，对阵美国将非常艰难",
                            @"静夜思"];
    NSArray *contentArray = @[@"世界杯F组小组赛第一轮希腊迎战黑山的比赛正在进行中，半场结束，希腊以42-16领先。效力于NBA密尔沃基雄鹿队的希腊前锋扬尼斯-阿德托昆博出场13分钟，6投4中，罚球2中2，得到10分6篮板2抢断，正负值为全队第二高的+17",@"日本阵中八村垒出场31分钟，10投3中，其中三分2中0，罚球10中9，得到15分7篮板2助攻2抢断，正负值为全场最低的-20。",@"土耳其以86-67大胜日本。赛后，土耳其男篮前锋切迪-奥斯曼接受了媒体采访。谈到本场比赛的胜利，奥斯曼说：“我们今天非常专注，在为期45天的准备阶段，我们一直在谈论日本男篮，最终我们击败了他们，这场胜利对于我们而言非常重要，我们的表现很好，每个人都做出了贡献。”谈到下一场小组赛对阵美国男篮，奥斯曼说：“一场艰难的比赛等待着我们，我们大概还有一天半的准备时间，我们会认真研究对手，努力打出最佳状态，争取拿下胜利。”", @"床前明月光\n疑似地上霜\n举头望明月\n低头思故乡。"];
    
    for (int i = 0; i < titleArray.count; i++) {
        FoldModel *model = [FoldModel new];
        model.title = titleArray[i];
        model.content = contentArray[i];
        [self.modelArray addObject:model];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoldLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FoldLabelCell class])];
    FoldModel *model = _modelArray[indexPath.row];
    cell.model = model;
    __weak typeof(self) weakSelf = self;
    cell.showContentCallback = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!model.isFold) {
            model.isFold = YES;
            [strongSelf.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
        } else {
            model.isFold = NO;
            [strongSelf.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
        }
        [UIView performWithoutAnimation:^{
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    return cell;
}
@end
