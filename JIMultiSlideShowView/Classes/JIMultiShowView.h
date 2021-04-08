//
//  JIMultiShowView.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JIMultiShowTableHeaderItem;

@protocol JIMultiShowViewDataSource <NSObject>

//获取数据
- (NSArray<JIMultiShowTableHeaderItem*>*)jiMultiShowViewGetDataArray;

@end

@interface JIMultiShowView : UIView

@property (nonatomic,weak) id<JIMultiShowViewDataSource>dataSource;

//获取完数据后需要reload
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
