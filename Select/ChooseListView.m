//
//  ChooseListView.m
//  Select
//
//  Created by YaSha_Tom on 2017/8/29.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ChooseListView.h"
#import "MyCollectionViewCell.h"
#import <YBPopupMenu.h>
#import "Tools.h"
#import "AddressData.h"
#import <UIButton+LXMImagePosition.h>
#import <Masonry.h>
#import "ChooseHeaderView.h"

@interface ChooseListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YBPopupMenuDelegate,UITextViewDelegate>{
    CGPoint pointMake;
    NSArray *titleAry;
    NSArray *dataArray;
    NSInteger integer;
    
}

@property (nonatomic,strong)NSMutableArray *selectDataArray;

//数据字典
@property (nonatomic, strong)NSDictionary *areaDic;
//省级数组
@property (nonatomic, strong)NSArray *provinceArr;
//城市数组
@property (nonatomic, strong)NSArray *cityArr;
//区、县数组
@property (nonatomic, strong)NSArray *districtArr;

@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong)UICollectionView *collection;


@end

@implementation ChooseListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectDataArray = [NSMutableArray arrayWithCapacity:100];
        titleAry = @[@[@"固定单价",@"固定总价"],@[[Tools getDateModel]],@[@"未开工",@"在建",@"停工",@"退场",@"完工",@"送审",@"审定"],@[@"请输入所属部门"],@[@"浙江省",@"杭州市",@"上城区"]];
        [self addCollectionView];
    }
    return self;
}

- (void)addCollectionView {
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.minimumInteritemSpacing = 2;
//    self.flowLayout.itemSize = CGSizeMake(self.frame.size.width/3-15, 30);
    self.flowLayout.minimumLineSpacing = 10;
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 667) collectionViewLayout:self.flowLayout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //注册cell标识
    [self.collection registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头标识
    [self.collection registerClass:[ChooseHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    //注册尾标识
    [self.collection registerClass:[UIView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    [self addSubview:self.collection];
}

#pragma mark --UICollectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return titleAry.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [titleAry[section] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return CGSizeMake(self.frame.size.width-30, 30);
    }else {
        return CGSizeMake(self.frame.size.width/3-15, 30);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        ChooseHeaderView *headerView = [ChooseHeaderView new];
        headerView.frame = CGRectMake(0, 0, self.frame.size.width, 30);
        [headerView setFilterTitle:@[@"合同形式",@"所属年份",@"项目状态",@"所属部门",@"工程地址"][indexPath.section] andIndex:indexPath.section];
        [reusableView addSubview:headerView];
        return reusableView;
    }
    return nil;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    if (section == 5) {
//      return CGSizeMake(self.frame.size.width, 60);
//    }else{
//        return CGSizeMake(self.frame.size.width, 0);
//    }
//    
//}

//设置单元格的数据
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"======%@",titleAry);
    [cell.chooseBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.chooseBtn.tag = indexPath.section*10 + indexPath.row;
    [cell setFilterIndexPath:indexPath andFilter:YES andTitleAry:titleAry];
    if (indexPath.section == 3) {
  
        UITextField *textFiled = [[UITextField alloc]init];
        textFiled.backgroundColor = [UIColor whiteColor];
        textFiled.placeholder = @"请输入所属部门...";
        textFiled.delegate = self;
        [cell addSubview:textFiled];
        [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.mas_centerX);
            make.centerY.mas_equalTo(cell.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width -30, 30));
        }];
        
    }
    return cell;
}

- (void)clickEvent:(UIButton *)btn{
    
    if (btn.tag == 10) {
        NSLog(@"点击了年分");
        dataArray = @[@"2015",@"2016",@"2017",@"2018",@"2019",@"2020"];
       pointMake = CGPointMake(140, 180);
    }
    if (btn.tag == 40) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
        NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *components = [areaDic allKeys];
        self.provinceArr = [AddressData getAddressDataArray:components andDiction:areaDic andArea:NO];
        dataArray = self.provinceArr;
        pointMake = CGPointMake(140, 470);
    }
    if (btn.tag == 41) {
        if (self.provinceArr.count > 0) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
            NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)integer]]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: self.provinceArr[integer]]];
            NSArray *cityArray = [dic allKeys];
            self.cityArr = [AddressData getAddressDataArray:cityArray andDiction:dic andArea:NO];
            dataArray = self.cityArr;
            pointMake = CGPointMake(232, 470);
            
        }else{
            NSLog(@"请选择省");
        }
    }
    if (btn.tag == 42) {
        if (self.cityArr.count > 0) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
            NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
            //获得选中的省
            NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[self.provinceArr indexOfObject:self.provinceArr[integer]]];
            NSLog(@"====-----===%@",provinceIndex);
            
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
            NSLog(@"==0000===%@",tmp);
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: self.provinceArr[integer]]];
            NSLog(@"===1111==%@",dic);
            NSArray *dicKeyArray = [dic allKeys];
            NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
                
                if ([obj1 integerValue] > [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if ([obj1 integerValue] < [obj2 integerValue]) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: integer]]];
            NSArray *cityKeyArray = [cityDic allKeys];
            self.districtArr = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
            dataArray = self.districtArr;
            pointMake = CGPointMake(292, 470);
            
        }else{
            NSLog(@"请选择省或市");
        }
    }
        [YBPopupMenu showAtPoint:pointMake titles:dataArray icons:nil menuWidth:80 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.dismissOnSelected = YES;
            popupMenu.isShowShadow = YES;
            popupMenu.tag = btn.tag;
            popupMenu.delegate = self;
            popupMenu.offset = 10;
            popupMenu.maxVisibleCount = 4;
            popupMenu.fontSize = 12;
            popupMenu.itemHeight = 34;
            popupMenu.arrowWidth = 0;//箭头
            popupMenu.type = YBPopupMenuTypeDefault;
            popupMenu.rectCorner = UIRectCornerBottomRight|UIRectCornerBottomLeft;
        }];
}

#pragma mark -- YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    integer = index;
    UIButton *button = (UIButton *)[self viewWithTag:ybPopupMenu.tag];
    [button setTitle:dataArray[index] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    [button setImagePosition:LXMImagePositionRight spacing:10];
}




@end
