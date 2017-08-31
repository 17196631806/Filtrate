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
        self.chooseBtn.backgroundColor = [UIColor redColor];
        
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
    
    [self.chooseBtn setTitle:titleAry[indexPath.section][indexPath.row] forState:UIControlStateNormal];
    if (indexPath.section == 1 || indexPath.section == 4) {
        [self.chooseBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        [self.chooseBtn setImagePosition:LXMImagePositionRight spacing:15];
    }
    
}
@end
