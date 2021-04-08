//
//  JIMultiShowTopBar.h
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//标题栏：用于视图上移后，显示在屏幕上方，可自定义或替换，根据需求实现相关接口即可

@interface JIMultiShowTopBar : UIView

- (void)changeTitleText:(NSString*)aStr;
- (void)changeBgOpacity:(float)aNum;

@end

NS_ASSUME_NONNULL_END
