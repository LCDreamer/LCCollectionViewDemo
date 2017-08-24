//
//  LCCollectionView.m
//  LCCollectionViewDemo
//
//  Created by LCTxzkj on 2017/8/23.
//  Copyright © 2017年 LCTxzkj. All rights reserved.
//

#import "LCCollectionView.h"
#import "LCCollectionViewCell.h"
#define Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define BIG_CELL_LONGITUDINAL_HEIGHT  128/2
#define SMALL_CELL_LONGITUDINAL_HEIGHT 96/2
#define SPACING 20


static NSString *kcellIdentifier = @"LCCollectionCell";

@interface LCCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,assign)float crossSpacing;
@property(nonatomic,assign)float BigLongitudinalSpacing;
@property(nonatomic,assign)float SmallLongitudinalSpacing;
@property(nonatomic,assign)NSInteger selectIndexPath;

@property(nonatomic,assign)float bigCellWidth;
@property(nonatomic,assign)float smallCellWidth;

@property(nonatomic,assign)NSInteger count;
@end

@implementation LCCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self registerNib:[UINib nibWithNibName:@"LCCollectionCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    self.delegate = self;
    self.dataSource = self;
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.width);
    _dataArray = @[@"1公里",@"2公里",@"3公里",@"5公里"];
    _count =[_dataArray count];
    _smallCellWidth = (self.bounds.size.width - SPACING*(_count+2))/_count; //计算小的Cell的宽 间距 SPACING 值为 20
    _bigCellWidth = _smallCellWidth + SPACING;//大的Cell 比 小的Cell 大20 刚好间距也是20
    self.BigLongitudinalSpacing = (self.frame.size.height - BIG_CELL_LONGITUDINAL_HEIGHT)/2;
    self.selectIndexPath =1;
    
}


#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    LCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    //设置圆角
    cell.layer.cornerRadius = 5;
    //将多余的部分切掉
    cell.layer.masksToBounds = YES;
    cell.kilometerLabel.text = [_dataArray objectAtIndex:indexPath.row];
   
    if (_selectIndexPath==indexPath.row) {
        [cell setBackgroundColor:[UIColor colorWithRed:17/255.0 green:24/255.0 blue:46/255.0  alpha:1]];
        cell.kilometerLabel.font = [UIFont systemFontOfSize:17];
    }else{
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.kilometerLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return cell;
    
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectIndexPath==indexPath.row) {
        return CGSizeMake(_bigCellWidth, BIG_CELL_LONGITUDINAL_HEIGHT);
    }else{
        return CGSizeMake(_smallCellWidth, SMALL_CELL_LONGITUDINAL_HEIGHT);
        
    }
    
}

//////定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(self.BigLongitudinalSpacing, SPACING, self.BigLongitudinalSpacing, SPACING);//分别为上、左、下、右
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SPACING;
}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndexPath = indexPath.row;
    if ([self.collectiondelegate respondsToSelector:@selector(selectkilometer:)]) {
        [self.collectiondelegate selectkilometer:[_dataArray objectAtIndex:indexPath.row]];
    }
    [self reloadData];
}
-(void)setKilometerType:(OrderModeSettingsDistance)kilometerType{
    switch (kilometerType) {
        case OrderModeSettingsDistance1KM:
            _selectIndexPath = 0;
            break;
        case OrderModeSettingsDistance2KM:
            _selectIndexPath = 1;
            break;
        case OrderModeSettingsDistance3KM:
            _selectIndexPath = 2;
            break;
        case OrderModeSettingsDistance5KM:
            _selectIndexPath = 3;
            break;
            
        default:
            break;
    }
    [self reloadData];
}


@end
