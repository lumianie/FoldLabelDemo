//
//  FoldModel.h
//  FoldLabelDemo
//
//  Created by Lee on 2019/9/1.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface FoldModel : NSObject
@property (nonatomic, assign)BOOL isFold;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
