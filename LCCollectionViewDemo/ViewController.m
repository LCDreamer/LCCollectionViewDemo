//
//  ViewController.m
//  LCCollectionViewDemo
//
//  Created by LCTxzkj on 2017/8/23.
//  Copyright © 2017年 LCTxzkj. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<LCCollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.collectiondelegate = self;
    self.collectionView.kilometerType = OrderModeSettingsDistance3KM;
    
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectkilometer:(NSString*)kilometer{
    NSLog(@"kilometer = %@",kilometer);
}


@end
