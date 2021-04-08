//
//  JIMultiShowTopBar.m
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import "JIMultiShowTopBar.h"

@interface JIMultiShowTopBar()
{
    UILabel *titleLabel;
}
@end

@implementation JIMultiShowTopBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.0 green:2/255.0 blue:91/255.0 alpha:1];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (CGRectGetHeight(self.frame)-30)/2, 250, 30)];
        if (@available(iOS 8.2, *)) {
            titleLabel.font = [UIFont respondsToSelector:@selector(systemFontOfSize:weight:)] ? [UIFont systemFontOfSize:20 weight:UIFontWeightMedium] : [UIFont systemFontOfSize:20];
        } else {
            titleLabel.font = [UIFont systemFontOfSize:20];
        }
        titleLabel.textColor = UIColor.whiteColor;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"Title";
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)changeTitleText:(NSString *)aStr{
    if(aStr.length > 0){
        titleLabel.text = [@" " stringByAppendingString:aStr];
    }
}

- (void)changeBgOpacity:(float)aNum{
    self.alpha = aNum;
}

@end
