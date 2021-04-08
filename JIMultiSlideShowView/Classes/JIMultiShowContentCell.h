//
//  JIMultiShowContentCell.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/12.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JIMultiShowTableHeaderItem;

@protocol JIMultiShowContentCellDelegate <NSObject>

- (void)showCollectionCellChangeOffset:(CGPoint)aPoint;

@end


//左右滑动视图-CollectionView的cell ，内嵌tableView，tableView的数据获取本Demo中未加入（仅有模拟数据获取的方法），请根据需求自行加入
@interface JIMultiShowContentCell : UICollectionViewCell

@property (nonatomic,weak) id<JIMultiShowContentCellDelegate>delegate;

- (void)drawCellWithdata:(JIMultiShowTableHeaderItem*)aData offSet:(CGPoint)aPoint;

- (void)addHeaderToSelfTableView:(UIView*)aView;

- (NSString*)getItemID;

- (void)configOffSetPoint:(CGPoint)aPoint;

@end

NS_ASSUME_NONNULL_END
