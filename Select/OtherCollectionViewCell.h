//
//  OtherCollectionViewCell.h
//  Select
//
//  Created by YaSha_Tom on 2017/9/1.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *titleLabel;

- (void)setFilterIndexPath:(NSIndexPath *)indexPath andFilter:(BOOL)isFilter andTitleAry:(NSArray *)titleAry;

@end
