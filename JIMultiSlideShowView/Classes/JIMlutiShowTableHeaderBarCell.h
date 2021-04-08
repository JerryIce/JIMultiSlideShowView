//
//  JIMlutiShowTableHeaderBarCell.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JIMultiShowTableHeaderItem;

NS_ASSUME_NONNULL_BEGIN

//JIMultiShowTableHeaderView_Bar的cell，可根据需求替换或自定义
@interface JIMlutiShowTableHeaderBarCell : UICollectionViewCell

- (void)drawCellWithData:(JIMultiShowTableHeaderItem*)aData;

@end

NS_ASSUME_NONNULL_END
