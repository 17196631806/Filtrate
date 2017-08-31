//
//  MyNavigationView.m
//  Select
//
//  Created by YaSha_Tom on 2017/8/31.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "MyNavigationView.h"
#import <Masonry.h>

@implementation MyNavigationView

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _leftButton = [[UIButton alloc]init];
        [_leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _titileLabel = [[UILabel alloc]init];
        _titileLabel.textAlignment = NSTextAlignmentCenter;
        _titileLabel.textColor = [UIColor whiteColor];
        _titileLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_titileLabel];
        [_titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(25);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(260, 30));
        }];
        
        _rightButton = [[UIButton alloc]init];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(22);
            make.left.mas_equalTo(self.titileLabel.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return self;
}

@end
