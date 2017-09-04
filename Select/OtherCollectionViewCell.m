//
//  OtherCollectionViewCell.m
//  Select
//
//  Created by YaSha_Tom on 2017/9/1.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "OtherCollectionViewCell.h"

@implementation OtherCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 30);
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

-(void)setFilterIndexPath:(NSIndexPath *)indexPath andFilter:(BOOL)isFilter andTitleAry:(NSArray *)titleAry{
    _titleLabel.text = titleAry[indexPath.section][indexPath.row];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.titleLabel.textColor = [UIColor blackColor];
}

@end
