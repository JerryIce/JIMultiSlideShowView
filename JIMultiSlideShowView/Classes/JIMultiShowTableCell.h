//
//  JIMultiShowTableCell.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/12.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JIMultiShowTableHeaderItem;

//自定义tableViewCell 可根据需求用其他tableview替换（需实现接口）
@interface JIMultiShowTableCell : UITableViewCell

- (void)drawCellWithData:(id)aData;

@end

NS_ASSUME_NONNULL_END
