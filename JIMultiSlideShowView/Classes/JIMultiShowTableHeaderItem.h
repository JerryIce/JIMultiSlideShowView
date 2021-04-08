//
//  JIMultiShowTableHeaderItem.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/12.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//JIMultiShowTableHeaderItem是JIMultiShowTableHeaderView中的数据源结构，作用:代表JIMultiShowTableHeaderView的不同显示内容。
//可自定义或扩展属性

@interface JIMultiShowTableHeaderItem : NSObject

@property (nonatomic,strong) NSString* itemID; //唯一确定显示内容
@property (nonatomic,strong) NSString* itemTitle; //用于显示内容的标题

@property (nonatomic) BOOL isSelected; //表示是否为显示状态；本Demo中表现为头部展示栏的按钮高亮状态

@end

NS_ASSUME_NONNULL_END
