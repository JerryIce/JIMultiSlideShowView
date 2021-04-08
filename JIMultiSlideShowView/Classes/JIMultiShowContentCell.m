//
//  JIMultiShowContentCell.m
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/12.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import "JIMultiShowContentCell.h"

#import "JIMultiShowTableHeaderItem.h"
#import "JIMultiShowTableHeaderView.h"
#import "JIMultiShowTableCell.h"

@interface JIMultiShowContentCell()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *dataTableView;
    UIView *headerTempView;
    UILabel *loadingLbl;
    UIImageView *footerBgCellView;

    NSMutableArray *dataArray;
    JIMultiShowTableHeaderItem *myHeaderItem;
    
    CGPoint moveOffset;
    BOOL isTouch;
    CGFloat headerH;
}
@end

@implementation JIMultiShowContentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        isTouch = NO;
        moveOffset = CGPointMake(0, 0);
        dataArray = [NSMutableArray arrayWithCapacity:20];
        
        headerH = 200;
        headerTempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), headerH)];
        headerTempView.userInteractionEnabled = YES;
  
        [self drawTableViewInRect:self.bounds];
        
        
    }
    return self;
}

- (void)drawCellWithdata:(JIMultiShowTableHeaderItem *)aData offSet:(CGPoint)aPoint{
    
    if(dataArray.count == 0){
        myHeaderItem = aData;
        
        //模拟获取数据逻辑 **仅测试使用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self->dataArray removeAllObjects];
            [self->dataArray addObjectsFromArray:[self testGetData]];

            [self->loadingLbl removeFromSuperview];
            [self->dataTableView reloadData];
            [self configOffSetPoint:self->moveOffset];
        });
    }
    if(aPoint.y != dataTableView.contentOffset.y){
        moveOffset = aPoint;
        [self configOffSetPoint:moveOffset];
    }
}


- (void) drawTableViewInRect:(CGRect)rect
{
    dataTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    dataTableView.showsVerticalScrollIndicator = NO;
    dataTableView.backgroundColor = UIColor.clearColor;
    dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [dataTableView registerClass:JIMultiShowTableCell.class forCellReuseIdentifier:@"JIMultiShowTableCellID"];
    [dataTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCellID"];
    dataTableView.delegate = self;
    dataTableView.dataSource = self;
    dataTableView.estimatedRowHeight = 0;
    dataTableView.estimatedSectionHeaderHeight = 0;
    dataTableView.estimatedSectionFooterHeight = 0;

    
    if (@available(iOS 11.0, *)) {
        dataTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    
    [self.contentView addSubview:dataTableView];
}


- (void)addHeaderToSelfTableView:(UIView *)hView
{
    for (UIView *iv in headerTempView.subviews) {
        if ([iv isKindOfClass:JIMultiShowTableHeaderView.class]) {
            [iv removeFromSuperview];
            break;
        }
    }
    
    CGRect frame = hView.frame;
    frame.origin.y = 0 ;
    hView.frame = frame;
    [headerTempView addSubview:hView];
    
}

- (void)configOffSetPoint:(CGPoint)aPoint{
    if(aPoint.y != dataTableView.contentOffset.y){
        moveOffset = aPoint;
        [dataTableView layoutIfNeeded];
        [dataTableView setContentOffset:moveOffset];
    }
}

- (NSString *)getItemID{
    NSString *res = myHeaderItem.itemID;
    if(res.length > 0){
        return res;
    }else{
        return @"";
    }
}

//Demo test 模拟获取数据延迟

- (NSArray*)testGetData{
    return @[@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",@"data",];
}


//MARK:- PullToRefreshT-ableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count == 0 ? 1 : dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(dataArray.count == 0){
        return 1500;
    }
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return headerTempView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(dataArray.count == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColor.clearColor;
        
        if(loadingLbl.superview != cell.contentView){
            loadingLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), 300)];
            loadingLbl.font = [UIFont systemFontOfSize:15];
            loadingLbl.textColor = UIColor.blackColor;
            loadingLbl.textAlignment = NSTextAlignmentCenter;
            loadingLbl.text = @"loading";
            [cell.contentView addSubview:loadingLbl];
        }
        return cell;
    }
    
    JIMultiShowTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JIMultiShowTableCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.clearColor;
    [cell drawCellWithData:dataArray[indexPath.row]];
    return cell;
    
}


//MARK:- scrollDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isTouch = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(isTouch){
        moveOffset = scrollView.contentOffset;
        if([self.delegate respondsToSelector:@selector(showCollectionCellChangeOffset:)]){
            [self.delegate showCollectionCellChangeOffset:moveOffset];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(isTouch){
        moveOffset = scrollView.contentOffset;
        if([self.delegate respondsToSelector:@selector(showCollectionCellChangeOffset:)]){
            [self.delegate showCollectionCellChangeOffset:moveOffset];
        }
        isTouch = NO;
    }
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

@end
