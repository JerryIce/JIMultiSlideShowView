//
//  JIMultiShowTableHeaderView_Bar.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JIMultiShowTableHeaderItem;

NS_ASSUME_NONNULL_BEGIN

@protocol JIMultiShowTableHeaderView_BarDelegate <NSObject>

- (void)jiMultiShowTableHeaderView_BarDidTouchSection:(JIMultiShowTableHeaderItem*)aItem;

@end


//JIMultiShowTableHeaderView中的滚动Bar，用于提示当前的展示视图或者切换
@interface JIMultiShowTableHeaderView_Bar : UIView

@property (nonatomic,weak) id<JIMultiShowTableHeaderView_BarDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray<JIMultiShowTableHeaderItem*>*)aData;

- (void)reloadBar;

@end

NS_ASSUME_NONNULL_END
