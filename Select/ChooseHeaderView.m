//
//  ChooseHeaderView.m
//  Select
//
//  Created by YaSha_Tom on 2017/8/31.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ChooseHeaderView.h"

@implementation ChooseHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
-(void)setFilterTitle:(NSString *)title andIndex:(NSInteger)index{
    _titleLab = [[UILabel alloc]init];
    _titleLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _titleLab.userInteractionEnabled = YES;
    _titleLab.frame = CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height);
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.numberOfLines = 0;
    _titleLab.text = title;
    _titleLab.tag = index;
    _titleLab.textColor = [UIColor blackColor];
    _titleLab.font = [UIFont systemFontOfSize:18];
    [self addSubview:_titleLab];
}

@end
