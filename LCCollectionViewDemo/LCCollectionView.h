//
//  LCCollectionView.h
//  LCCollectionViewDemo
//
//  Created by LCTxzkj on 2017/8/23.
//  Copyright © 2017年 LCTxzkj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LCCollectionViewDelegate;

typedef NS_ENUM(NSUInteger, OrderModeSettingsDistance) {
    OrderModeSettingsDistance1KM = 1,
    OrderModeSettingsDistance2KM = 2,
    OrderModeSettingsDistance3KM = 3,
    OrderModeSettingsDistance5KM = 5,
};

@interface LCCollectionView : UICollectionView
@property (nonatomic,copy)NSArray * dataArray;
@property (nonatomic,assign)OrderModeSettingsDistance kilometerType;
@property(nonatomic,weak)id <LCCollectionViewDelegate> collectiondelegate;


@end

@protocol LCCollectionViewDelegate <NSObject>
-(void)selectkilometer:(NSString*)kilometer;
@end
