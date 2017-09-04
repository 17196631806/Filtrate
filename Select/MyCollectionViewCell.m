//
//  MyCollectionViewCell.m
//  Select
//
//  Created by YaSha_Tom on 2017/8/30.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import <Masonry.h>
#import <UIButton+LXMImagePosition.h>

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.chooseBtn = [[UIButton alloc]init];
        self.chooseBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        self.chooseBtn.backgroundColor = [UIColor whiteColor];
        //设置button文字的位置
        self.chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //调整与边距的距离
        self.chooseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [self.chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.chooseBtn];
        [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width, 30));
        }];
    }
    return self;
}
-(void)setFilterIndexPath:(NSIndexPath *)indexPath andFilter:(BOOL)isFilter andTitleAry:(NSArray *)titleAry {
       NSLog(@"=======%@",titleAry[indexPath.section][indexPath.row]);
    if (indexPath.section != 3) {
   
        [self.chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.chooseBtn setTitle:titleAry[indexPath.section][indexPath.row] forState:UIControlStateNormal];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(55, 11, 12, 8)];
        imageView.image = [UIImage imageNamed:@"下拉"];
        [self.chooseBtn addSubview:imageView];
        
    }
  
    
}
@end
