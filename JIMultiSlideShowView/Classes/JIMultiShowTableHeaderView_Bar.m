//
//  JIMultiShowTableHeaderView_Bar.m
//  JIMultiShowViewDemo
//
//  Created by JerryIce on 2019/7/13.
//  Copyright © 2019 JerryIce. All rights reserved.
//

#import "JIMultiShowTableHeaderView_Bar.h"

#import "JIMlutiShowTableHeaderBarCell.h"
#import "JIMultiShowTableHeaderItem.h"

@interface JIMultiShowTableHeaderView_Bar()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *dataCollectionView;
    NSMutableArray<JIMultiShowTableHeaderItem*> *dataArray;
}
@end

@implementation JIMultiShowTableHeaderView_Bar

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray<JIMultiShowTableHeaderItem*>*)aData
{
    self = [super initWithFrame:frame];
    if (self) {
        dataArray = [NSMutableArray arrayWithCapacity:12];
        if(aData.count > 0){
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:aData];
        }
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    layout.itemSize = CGSizeMake(80, 30);
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    dataCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    dataCollectionView.showsHorizontalScrollIndicator = NO;
    dataCollectionView.delegate = self;
    dataCollectionView.dataSource = self;
    dataCollectionView.backgroundColor = UIColor.clearColor;
    [dataCollectionView registerClass:JIMlutiShowTableHeaderBarCell.class forCellWithReuseIdentifier:@"JIMlutiShowTableHeaderBarCellID"];
    [self addSubview:dataCollectionView];
}


//MARK: - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JIMlutiShowTableHeaderBarCell *cell = (JIMlutiShowTableHeaderBarCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"JIMlutiShowTableHeaderBarCellID" forIndexPath:indexPath];
    [cell drawCellWithData:[dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.delegate respondsToSelector:@selector(jiMultiShowTableHeaderView_BarDidTouchSection:)]){
        [self.delegate jiMultiShowTableHeaderView_BarDidTouchSection:[dataArray objectAtIndex:indexPath.row]];
    }
    
}

- (void)reloadBar{
    if(dataCollectionView){
        [self moveToCurrCell];
        
    }
}

- (void)moveToCurrCell{
    
    NSUInteger index = 0;
    for (JIMultiShowTableHeaderItem *item in dataArray) {
        if(item.isSelected == YES){
            index = [dataArray indexOfObject:item];
            
            NSArray<NSIndexPath *> *visIndexes = [dataCollectionView indexPathsForVisibleItems];
            if(visIndexes.count == 0){
                return;
            }
            
            int notVisableType = 1; // 1 left 2 vis 3 right
            for (NSIndexPath *aPath in visIndexes) {
                if(aPath.row == index){
                    UICollectionViewCell *cell = [dataCollectionView cellForItemAtIndexPath:aPath];
                    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
                    CGRect modiRect = [cell convertRect:cell.contentView.frame toView:window];
                    if(modiRect.origin.x >= 0 && modiRect.origin.x + modiRect.size.width <= UIScreen.mainScreen.bounds.size.width){
                        notVisableType = 2;
                    }else if(modiRect.origin.x < 0){
                        notVisableType = 1;
                    }else{
                        notVisableType = 3;
                    }
                }
            }
            
            if(notVisableType == 1){
                [dataCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
                [dataCollectionView reloadData];
            }else if(notVisableType == 3){
                [dataCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
                [dataCollectionView reloadData];
            }else{
                [dataCollectionView reloadData];
            }
            
            break;
        }
    }
}

@end
