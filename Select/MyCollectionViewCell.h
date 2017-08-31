//
//  MyCollectionViewCell.h
//  Select
//
//  Created by YaSha_Tom on 2017/8/30.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIButton *chooseBtn;

-(void)setFilterIndexPath:(NSIndexPath *)indexPath andFilter:(BOOL)isFilter andTitleAry:(NSArray *)titleAry;

@end
