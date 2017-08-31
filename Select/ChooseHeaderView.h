//
//  ChooseHeaderView.h
//  Select
//
//  Created by YaSha_Tom on 2017/8/31.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseHeaderView : UICollectionReusableView

@property(strong,nonatomic)UILabel *titleLab;
-(void)setFilterTitle:(NSString *)title andIndex:(NSInteger)index;

@end
