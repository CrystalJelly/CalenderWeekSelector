//
//  WeekSelectorCell.m
//  CalenderWeekSelector
//
//  Created by 李国栋 on 2019/5/10.
//  Copyright © 2019 李国栋. All rights reserved.
//

#import "WeekSelectorCell.h"

@interface WeekSelectorCell()

@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation WeekSelectorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setWeek:(Week *)week {
    _week = week;
    _weekLabel.text = week.title;
    _timeLabel.text = week.timeStr;
}

@end
