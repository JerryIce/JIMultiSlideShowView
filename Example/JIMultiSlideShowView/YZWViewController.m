//
//  YZWViewController.m
//  JIMultiSlideShowView
//
//  Created by jerryelectricity@me.com on 04/08/2021.
//  Copyright (c) 2021 jerryelectricity@me.com. All rights reserved.
//

#import "YZWViewController.h"

#import "JIMultiShowView.h"
#import "JIMultiShowTableHeaderItem.h"

@interface YZWViewController ()<JIMultiShowViewDataSource>
{
    JIMultiShowView *jiView;
}

@end

@implementation YZWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //创建
    jiView = [[JIMultiShowView alloc] initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-44)];
    jiView.dataSource = self;
    [self.view addSubview:jiView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //模拟获取数据延迟
        [self->jiView reloadData];
    });
    
}

//JIMultiShowViewDataSource

- (NSArray<JIMultiShowTableHeaderItem *> *)jiMultiShowViewGetDataArray{
    
    NSMutableArray *resArray = [NSMutableArray arrayWithCapacity:12];
    for (int i = 1; i<13; i++) {
        JIMultiShowTableHeaderItem *item = [[JIMultiShowTableHeaderItem alloc] init];
        item.itemID = [NSString stringWithFormat:@"%d",i];
        item.itemTitle = [NSString stringWithFormat:@"Title-%d",i];
        [resArray addObject:item];
    }
    return resArray;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
