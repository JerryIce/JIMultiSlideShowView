//
//  ShowTableHeaderView.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/12.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JIMultiShowTableHeaderItem;

@protocol JIMultiShowTableHeaderViewDelegate <NSObject>

- (void)showTableHeaderViewDidTouchBtn:(JIMultiShowTableHeaderItem *)aItem;

@end

//JIMultiShowTableHeaderView:头部视图
@interface JIMultiShowTableHeaderView : UIView

@property (nonatomic,weak) id<JIMultiShowTableHeaderViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray<JIMultiShowTableHeaderItem*> *)aData;

- (void)drawHeaderViewData:(JIMultiShowTableHeaderItem*)aData;

@end

NS_ASSUME_NONNULL_END
