//
//  ViewController.m
//  CalenderWeekSelector
//
//  Created by 李国栋 on 2019/5/10.
//  Copyright © 2019 李国栋. All rights reserved.
//

#import "ViewController.h"
#import "Month.h"
#import "WeekSelectorCell.h"
#import "CollectionReusableView.h"
#import "DateTools.h"

#define ScreenW [[UIScreen mainScreen] bounds].size.width


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<Month *> *dataArr;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.view addSubview:self.collectionView];
}


- (void)loadData {
    NSDate *currentDate = [NSDate date];
    
    NSDate *startDate = [currentDate dateByAddingMonths:-12];
    
    for (int i = (int)startDate.month; i < 13; i++) {
        NSDate *firstDay = [NSDate dateWithYear:startDate.year month:i day:1];
        Month *month = [[Month alloc] init];
        month.title = [firstDay formattedDateWithFormat:@"yyyy-M"];
        month.weeks = [NSMutableArray array];
        [self loadWeeks:firstDay weekNo:1 month:month];
    }
    
    for (int i = 1; i <= (int)startDate.month; i++) {
        NSDate *firstDay = [NSDate dateWithYear:currentDate.year month:i day:1];
        Month *month = [[Month alloc] init];
        month.title = [firstDay formattedDateWithFormat:@"yyyy-M"];
        month.weeks = [NSMutableArray array];
        [self loadWeeks:firstDay weekNo:1 month:month];
    }
    
}

- (void)loadWeeks:(NSDate *)date weekNo:(int)no month:(Month *)month{
    NSDate *beginDay;
    if (date.weekday == 2) {
        beginDay = date;
    }
    else {
        beginDay = [date dateByAddingDays:(9 - date.weekday)];
    }
    NSDate *endDay = [beginDay dateByAddingDays:6];
    NSString *xq1Str = [beginDay formattedDateWithFormat:@"M.d"];
    NSString *xq2Str = [endDay formattedDateWithFormat:@"M.d"];
    NSString *startWeek = [NSString stringWithFormat:@"%@~%@ 第%d周", xq1Str,xq2Str,no];
    Week *week = [[Week alloc] init];
    week.title = [NSString stringWithFormat:@"第%d周", no];
    week.beginDate = beginDay;
    week.endDate = endDay;
    week.timeStr = [NSString stringWithFormat:@"%@~%@", xq1Str,xq2Str];
    [month.weeks addObject:week];
    NSLog(@"%@",startWeek);
    NSDate *nextBeginDate = [endDay dateByAddingDays:1];
    if (nextBeginDate.day <= date.daysInMonth && nextBeginDate.month == beginDay.month && [nextBeginDate isEarlierThan:[NSDate date]]) {
        no ++;
        [self loadWeeks:nextBeginDate weekNo:no month:month];
    }
    else {
        no = 1;
        [self.dataArr addObject:month];
    }
}

#pragma mark UICollectionViewDelegate UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr[section].weeks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeekSelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[WeekSelectorCell alloc] init];
    }
    cell.week = self.dataArr[indexPath.section].weeks[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionReusableView *headerView = (CollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (!headerView) {
        headerView = [[CollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    }
    
    headerView.title = self.dataArr[indexPath.section].title;
    return headerView;
}


#pragma mark Getter

- (NSMutableArray<Month *> *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (ScreenW - 15) / 4;
        layout.itemSize = CGSizeMake(itemW, itemW);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 5;
        layout.headerReferenceSize = CGSizeMake(ScreenW, 30);
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WeekSelectorCell class]) bundle:nil]  forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _collectionView;
}



@end
