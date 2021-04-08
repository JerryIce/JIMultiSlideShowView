//
//  JIMultiShowView.m
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import "JIMultiShowView.h"

#import "JIMultiShowContentCell.h"
#import "JIMultiShowTableHeaderView.h"
#import "JIMultiShowTableHeaderItem.h"
#import "JIMultiShowTopBar.h"

@interface JIMultiShowView ()<UICollectionViewDelegate,UICollectionViewDataSource,JIMultiShowContentCellDelegate,JIMultiShowTableHeaderViewDelegate>
{
    //UI
    UICollectionView *dataCollectionView; //内容展示视图
    JIMultiShowTopBar *topBarView;//自定义导航标题栏
    JIMultiShowTableHeaderView *headerView; //内容展示视图中tableView的Header
    
    UIImageView *bgImageView; //固定背景
    UILabel *loadingTintLbl; //加载数据提示
    //UI默认参数
    CGFloat headerH; //headerView高度
    CGFloat bgImageH;//固定背景高度
    CGFloat topBarH; //自定义导航标题栏高度
    
    //Data
    NSMutableArray<JIMultiShowTableHeaderItem*> *dataItemArray;
    
    NSUInteger currItemIndex;
    NSUInteger changingIndex;
    CGPoint currOffSet;
}

@end

@implementation JIMultiShowView

- (void)dealloc
{
    NSLog(@"JIMultiShowView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        
        dataItemArray = [NSMutableArray arrayWithCapacity:12];
        currItemIndex = 0;
        currOffSet = CGPointMake(0, 0);
        headerH = 200;
        bgImageH = 250;
        topBarH = 60;
        
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), bgImageH)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.image = [UIImage imageNamed:@"JI_bgImage_1"];
    [self addSubview:bgImageView];
    
    loadingTintLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, (CGRectGetHeight(bgImageView.frame) - 60)/2 - 40, 280, 60)];
    if (@available(iOS 8.2, *)) {
        loadingTintLbl.font = [UIFont respondsToSelector:@selector(systemFontOfSize:weight:)] ? [UIFont systemFontOfSize:40 weight:UIFontWeightMedium] : [UIFont systemFontOfSize:40];
    } else {
        loadingTintLbl.font = [UIFont systemFontOfSize:40];
    }
    loadingTintLbl.textColor = UIColor.whiteColor;
    loadingTintLbl.textAlignment = NSTextAlignmentLeft;
    loadingTintLbl.text = @"Loading";
    [bgImageView addSubview:loadingTintLbl];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    dataCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    dataCollectionView.showsHorizontalScrollIndicator = NO;
    dataCollectionView.backgroundColor = UIColor.clearColor;
    dataCollectionView.pagingEnabled = YES;
    dataCollectionView.bounces = NO;
    dataCollectionView.delegate = self;
    dataCollectionView.dataSource = self;
    [dataCollectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCellID"];
    [self addSubview:dataCollectionView];
    
    [self drawTopBarView];

}

- (void)drawTopBarView{
    topBarView = [[JIMultiShowTopBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), topBarH)];
    [topBarView changeBgOpacity:0.0];
    [self addSubview:topBarView];
}


- (void)refreshBgImageAndTopBarAnimationWithDis:(float)dis{
    
    CGRect tempFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), bgImageH);
    if(dis<0){
        tempFrame.size.height -= dis ;
    }else{
        tempFrame.origin.y = -dis;
    }
    bgImageView.frame = tempFrame;
    
    if(dis >= topBarH){
        [topBarView changeBgOpacity:1.0];
    }else{
        [topBarView changeBgOpacity:0.0];
    }
}

- (void)reloadData{
    if([self.dataSource respondsToSelector:@selector(jiMultiShowViewGetDataArray)]){
        [dataItemArray removeAllObjects];
        
        NSMutableArray<JIMultiShowTableHeaderItem*>* resArray = [self.dataSource jiMultiShowViewGetDataArray].mutableCopy;
        if(resArray.count > 0){
            for (int i = 0; i < resArray.count; i++) {
                [dataCollectionView registerClass:JIMultiShowContentCell.class forCellWithReuseIdentifier:[NSString stringWithFormat:@"JIMultiShowContentCellID%d",i]];
            }
            resArray.firstObject.isSelected = YES;
            [dataItemArray addObjectsFromArray:resArray];
            
            [loadingTintLbl removeFromSuperview];
            [self createHeaderView];
            [topBarView changeTitleText:[dataItemArray objectAtIndex:currItemIndex].itemTitle];
        }
    }
    [dataCollectionView reloadData];
}

- (void)createHeaderView{
    if(!headerView){
        headerView = [[JIMultiShowTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), headerH) data:dataItemArray];
        headerView.delegate = self;
    }
}

- (void)bringHeaderViewToSuperView{
    if(headerView.superview != self ){
        
        CGRect modiFrame = [self convertRect:headerView.frame fromView:headerView.superview];
        
        if(modiFrame.origin.y != -currOffSet.y ){
            modiFrame.origin.y = -500;
        }
        [headerView removeFromSuperview];
        CGRect tempFrame = headerView.frame;
        tempFrame.origin.y = modiFrame.origin.y;
        headerView.frame = tempFrame;
        [self insertSubview:headerView belowSubview:topBarView];
    }
}

- (void)bringHeaderViewToSectionHearderWithChangedIndex:(NSUInteger)aIndex{
    
    NSString *changedID = [dataItemArray objectAtIndex:aIndex].itemID;
    NSArray<JIMultiShowContentCell*> *visCells = [dataCollectionView visibleCells];
    for (JIMultiShowContentCell *cell in visCells) {
        if([[cell getItemID] isEqualToString:changedID]){
            if(headerView.superview){
                [headerView removeFromSuperview];
            }
            [cell addHeaderToSelfTableView:headerView];
            break;
        }
    }
    
    for (JIMultiShowTableHeaderItem *aItem in dataItemArray) {
        if([aItem.itemID isEqualToString:changedID]){
            aItem.isSelected = YES;
            currItemIndex = [dataItemArray indexOfObject:aItem];
        }else{
            aItem.isSelected = NO;
        }
    }
    [headerView drawHeaderViewData:[dataItemArray objectAtIndex:currItemIndex]];
}


//MARK:- JIMultiShowContentCellDelegate

- (void)showCollectionCellChangeOffset:(CGPoint)aPoint{
    currOffSet = aPoint;
    [self refreshBgImageAndTopBarAnimationWithDis:currOffSet.y];
}

//MARK: - JIMultiShowTableHeaderViewDelegate

- (void)showTableHeaderViewDidTouchBtn:(JIMultiShowTableHeaderItem *)aItem{
    if(aItem){
        
        [self scrollViewWillBeginDragging:dataCollectionView];
        
        NSUInteger changedIndex = [dataItemArray indexOfObject:aItem];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:changedIndex inSection:0];
        [dataCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft
                                           animated:NO];
        
        [dataCollectionView reloadItemsAtIndexPaths:@[indexPath]];
        [dataCollectionView endEditing:YES];
        
        [self scrollViewDidEndDecelerating:dataCollectionView];
        
    }
}

//MARK:- UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataItemArray.count == 0 ? 1 : dataItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(dataItemArray.count == 0){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        return cell;
    }
    
    JIMultiShowContentCell *cell = (JIMultiShowContentCell*)[collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"JIMultiShowContentCellID%ld",(long)indexPath.row] forIndexPath:indexPath];
    [cell drawCellWithdata:[dataItemArray objectAtIndex:indexPath.row] offSet:currOffSet];
    cell.delegate = self;
    if (!headerView.superview) {
        [cell addHeaderToSelfTableView:headerView];
    }
    
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self bringHeaderViewToSuperView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSArray<JIMultiShowContentCell*> *visCells = [dataCollectionView visibleCells];
    NSString *currID = [dataItemArray objectAtIndex:currItemIndex].itemID;
    for (JIMultiShowContentCell *cell in visCells) {
        if(![[cell getItemID] isEqualToString:currID]){
            CGFloat tolance = headerH - topBarH;
            if(currOffSet.y <= tolance){
                [cell configOffSetPoint:currOffSet];
            }else{
                [cell configOffSetPoint:CGPointMake(0, tolance)];
            }
        }
    }
    
    CGPoint offSet = scrollView.contentOffset;
    NSUInteger temp = offSet.x / CGRectGetWidth(self.frame);
    if(changingIndex != temp){
        changingIndex = temp;
        for (int i = 0 ; i < dataItemArray.count; i ++) {
            JIMultiShowTableHeaderItem *item = [dataItemArray objectAtIndex:i];
            if(i == changingIndex){
                item.isSelected = YES;
            }else{
                item.isSelected = NO;
            }
        }
        [headerView drawHeaderViewData:[dataItemArray objectAtIndex:changingIndex]];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offSet = scrollView.contentOffset;
    NSUInteger changedIndex = offSet.x / CGRectGetWidth(self.frame);
    
    [self bringHeaderViewToSectionHearderWithChangedIndex:changedIndex];
    if(topBarView){
        [topBarView changeTitleText:[dataItemArray objectAtIndex:currItemIndex].itemTitle];
    }
}

@end
