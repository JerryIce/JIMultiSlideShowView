//
//  JIMlutiShowTableHeaderBarCell.m
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import "JIMlutiShowTableHeaderBarCell.h"

#import "JIMultiShowTableHeaderItem.h"

@interface JIMlutiShowTableHeaderBarCell()
{
    JIMultiShowTableHeaderItem *myData;
    
    UIButton *monthBtn;
    UILabel *titleLabel;
}
@end

@implementation JIMlutiShowTableHeaderBarCell

- (void)drawCellWithData:(JIMultiShowTableHeaderItem*)data{
    
    myData = data;
    if(!monthBtn){
        monthBtn = [[UIButton alloc] initWithFrame:self.contentView.bounds];
        [monthBtn setImage:[UIImage imageNamed:@"JIMultiShowView_btn_1"] forState:UIControlStateNormal];
        [monthBtn setImage:[UIImage imageNamed:@"JIMultiShowView_btn_2"] forState:UIControlStateSelected];
        monthBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:monthBtn];
    }
    monthBtn.selected = myData.isSelected;
    
    if(!titleLabel){
        titleLabel = [[UILabel alloc] initWithFrame:monthBtn.frame];
        if (@available(iOS 8.2, *)) {
            titleLabel.font = [UIFont respondsToSelector:@selector(systemFontOfSize:weight:)] ? [UIFont systemFontOfSize:12 weight:UIFontWeightMedium] : [UIFont systemFontOfSize:12];
        } else {
            titleLabel.font = [UIFont systemFontOfSize:12];
        }
        titleLabel.textColor = UIColor.whiteColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:titleLabel];
    }
    titleLabel.text = myData.itemTitle;
}

@end
