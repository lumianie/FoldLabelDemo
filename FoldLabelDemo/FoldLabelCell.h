//
//  FoldLabelCell.h
//  FoldLabelDemo
//
//  Created by Lee on 2019/9/1.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^showContentCallback)(void);

@interface FoldLabelCell : UITableViewCell
@property (nonatomic, strong) FoldModel *model;
@property (nonatomic, strong) showContentCallback showContentCallback;

@end

NS_ASSUME_NONNULL_END
