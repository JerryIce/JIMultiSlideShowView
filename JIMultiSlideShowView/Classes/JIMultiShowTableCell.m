//
//  ShowTableViewCell.m
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/12.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import "JIMultiShowTableCell.h"
@interface JIMultiShowTableCell()
{
    UIView *colorView;
}

@end

@implementation JIMultiShowTableCell

- (void)drawCellWithData:(id)aData{
    //custom drawCell
    
    //test
    self.contentView.backgroundColor = UIColor.clearColor;
    if(!colorView){
        colorView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.contentView.frame) - 20, CGRectGetHeight(self.contentView.frame) - 10)];
        colorView.layer.cornerRadius = 10;
        colorView.layer.masksToBounds = YES;
        [self.contentView addSubview:colorView];
    }
    colorView.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];;
}

@end
