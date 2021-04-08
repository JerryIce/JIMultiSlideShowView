//
//  ShowTableHeaderView.m
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/12.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import "JIMultiShowTableHeaderView.h"

#import "JIMultiShowTableHeaderView_Bar.h"
#import "JIMultiShowTableHeaderItem.h"


@interface JIMultiShowTableHeaderView()<JIMultiShowTableHeaderView_BarDelegate>
{
    UILabel *titleLbl;//标题展示
    JIMultiShowTableHeaderView_Bar *bar;//滚动Bar
    
    NSArray<JIMultiShowTableHeaderItem *> *myDataItemArray;
}
@end

@implementation JIMultiShowTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray<JIMultiShowTableHeaderItem*>*)aData;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        myDataItemArray = aData;
        
        [self drawHeaderViewData:myDataItemArray.firstObject];
    }
    return self;
}


- (void)drawHeaderViewData:(JIMultiShowTableHeaderItem*)aData{
    
    NSUInteger index = 0;
    for (JIMultiShowTableHeaderItem *item in myDataItemArray) {
        if([aData.itemID isEqualToString:item.itemID]){
            index = [myDataItemArray indexOfObject:aData];
            break;
        }
    }
    
    if(!titleLbl){
        titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, (CGRectGetHeight(self.frame) - 60)/2 - 20, 300, 60)];
        if (@available(iOS 8.2, *)) {
            titleLbl.font = [UIFont respondsToSelector:@selector(systemFontOfSize:weight:)] ? [UIFont systemFontOfSize:40 weight:UIFontWeightMedium] : [UIFont systemFontOfSize:40];
        } else {
            titleLbl.font = [UIFont systemFontOfSize:40];
        }
        titleLbl.textColor = UIColor.whiteColor;
        titleLbl.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLbl];
    }
    titleLbl.text = [@"Showed:" stringByAppendingString: myDataItemArray[index].itemTitle];
    
    
    if(!bar){
        bar = [[JIMultiShowTableHeaderView_Bar alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLbl.frame) + 30, CGRectGetWidth(self.frame), 36) data:myDataItemArray];
        bar.delegate = self;
        [self addSubview:bar];
    }else{
        [bar reloadBar];
    }
}

//JIMultiShowTableHeaderView_BarDelegate

- (void)jiMultiShowTableHeaderView_BarDidTouchSection:(JIMultiShowTableHeaderItem *)aItem{
    if([self.delegate respondsToSelector:@selector(showTableHeaderViewDidTouchBtn:)]){
        [self.delegate showTableHeaderViewDidTouchBtn:aItem];
    }
}
@end
