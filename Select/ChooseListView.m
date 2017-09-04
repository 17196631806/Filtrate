//
//  ChooseListView.m
//  Select
//
//  Created by YaSha_Tom on 2017/8/29.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ChooseListView.h"
#import "MyCollectionViewCell.h"
#import "OtherCollectionViewCell.h"
#import <YBPopupMenu.h>
#import "Tools.h"
#import "AddressData.h"
#import <UIButton+LXMImagePosition.h>
#import <Masonry.h>
#import "ChooseHeaderView.h"
#import <CoreLocation/CoreLocation.h>

@interface ChooseListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YBPopupMenuDelegate,UITextViewDelegate,CLLocationManagerDelegate>{
    CGPoint pointMake;
    NSArray *titleAry;
    NSArray *dataArray;
    NSInteger integer;
    
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
}

@property (nonatomic,strong)NSMutableArray *selectDataArray;

//数据字典
@property (nonatomic, strong)NSDictionary *areaDic;
//省级数组
@property (nonatomic, strong)NSArray *provinceArr;

@property (nonatomic, strong)NSString *provinceStr;
//城市数组
@property (nonatomic, strong)NSArray *cityArr;

@property (nonatomic, strong)NSString *cityStr;

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
        
      
        [self locate];
    }
    return self;
}

- (void)locate {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];//iOS8需要加上，不然定位失败
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;  //最精确模式
        locationManager.distanceFilter = 100.0f; //至少10米才请求一次数据
        [locationManager startUpdatingLocation]; //开始定位
    }
    
}

#pragma mark CoreLocation delegate
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;//市
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
        
        NSLog(@"%@",placeMark.administrativeArea);//省
        NSLog(@"%@",placeMark.locality); //市
        NSLog(@"%@",placeMark.subLocality);//区
            titleAry = @[@[@"固定单价",@"固定总价"],@[[Tools getDateModel]],@[@"未开工",@"在建",@"停工",@"退场",@"完工",@"送审",@"审定"],@[@"请输入所属部门"],@[placeMark.administrativeArea,placeMark.locality,placeMark.subLocality]];
             [self addCollectionView];
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
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
    [self.collection registerClass:[OtherCollectionViewCell class] forCellWithReuseIdentifier:@"otherCell"];
    //注册头标识
    [self.collection registerClass:[ChooseHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    //注册尾标识
    [self.collection registerClass:[UIView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    [self addSubview:self.collection];
    
    UIButton *resetButton = [[UIButton alloc]init];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    resetButton.backgroundColor = [UIColor whiteColor];
    [resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resetButton];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.collection.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2, 30));
    }];
    
    UIButton *determineButton = [[UIButton alloc]init];
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    determineButton.backgroundColor = [UIColor grayColor];
    [determineButton addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:determineButton];
    [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(resetButton.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2, 30));
    }];
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

//设置单元格的数据
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 4 ||indexPath.section == 3) {
        MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        [cell.chooseBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = indexPath.section*10 + indexPath.row;
        [cell setFilterIndexPath:indexPath andFilter:YES andTitleAry:titleAry];
        if (indexPath.section == 3) {
            
            UITextField *textFiled = [[UITextField alloc]init];
            textFiled.backgroundColor = [UIColor whiteColor];
            textFiled.placeholder = @"请输入所属部门...";
            [cell addSubview:textFiled];
            [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(cell.mas_centerX);
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(self.frame.size.width -30, 30));
            }];
            
        }
        return cell;
    }else{
        OtherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"otherCell" forIndexPath:indexPath];
        [cell setFilterIndexPath:indexPath andFilter:YES andTitleAry:titleAry];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //获得组标示
    if (indexPath.section != 3) {
        NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:indexPath.section];
        [self.collection reloadSections:indexSet];
        OtherCollectionViewCell *cell = (OtherCollectionViewCell *)[self.collection cellForItemAtIndexPath:indexPath];
        NSLog(@"------%@",cell.titleLabel.text);
        cell.titleLabel.textColor = [UIColor redColor];
        cell.layer.borderWidth = 1.0f;
        cell.layer.borderColor = [UIColor redColor].CGColor;        
    }
}

- (void)clickEvent:(UIButton *)btn{
    
    if (btn.tag == 10) {
        NSLog(@"点击了年分");
        dataArray = @[@"2015",@"2016",@"2017",@"2018",@"2019",@"2020"];
       pointMake = CGPointMake(164, 150);
    }
    if (btn.tag == 40) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
        NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *components = [areaDic allKeys];
        self.provinceArr = [AddressData getAddressDataArray:components andDiction:areaDic andArea:NO];
        dataArray = self.provinceArr;
        pointMake = CGPointMake(164, 435);
    }
    if (btn.tag == 41) {
        if (self.provinceStr.length > 0) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
            NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)integer]]];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: self.provinceStr]];
            NSArray *cityArray = [dic allKeys];
            self.cityArr = [AddressData getAddressDataArray:cityArray andDiction:dic andArea:NO];
            dataArray = self.cityArr;
            pointMake = CGPointMake(245, 435);
            
        }else{
            NSLog(@"请选择省");
        }
    }
    if (btn.tag == 42) {
        if (self.cityStr.length > 0) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
            NSDictionary *areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
            //获得选中的省
            NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[self.provinceArr indexOfObject:self.provinceStr]];
            NSLog(@"====-----===%@",provinceIndex);
            
            NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
            NSLog(@"==0000===%@",tmp);
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: self.provinceStr]];
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
            pointMake = CGPointMake(330, 435);
            
        }else{
            NSLog(@"请选择省或市");
        }
    }
        [YBPopupMenu showAtPoint:pointMake titles:dataArray icons:nil menuWidth:70 otherSettings:^(YBPopupMenu *popupMenu) {
            popupMenu.dismissOnSelected = YES;
            popupMenu.isShowShadow = YES;
            popupMenu.tag = btn.tag;
            popupMenu.delegate = self;
            popupMenu.offset = 10;
            popupMenu.maxVisibleCount = 4;
            popupMenu.fontSize = 11;
            popupMenu.itemHeight = 44;
            popupMenu.arrowWidth = 0;//箭头
            popupMenu.type = YBPopupMenuTypeDefault;
            popupMenu.rectCorner = UIRectCornerBottomRight|UIRectCornerBottomLeft;
        }];
}

#pragma mark -- YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu {
    integer = index;
    UIButton *button = (UIButton *)[self viewWithTag:ybPopupMenu.tag];
    if (ybPopupMenu.tag == 40) {
        self.provinceStr = dataArray[index];
    }else if(ybPopupMenu.tag == 41){
        self.cityStr = dataArray[index];
    }
    [button setTitle:dataArray[index] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    [button setImagePosition:LXMImagePositionRight spacing:10];
}




@end
