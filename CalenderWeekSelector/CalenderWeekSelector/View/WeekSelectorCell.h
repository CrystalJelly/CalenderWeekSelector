//
//  WeekSelectorCell.h
//  CalenderWeekSelector
//
//  Created by 李国栋 on 2019/5/10.
//  Copyright © 2019 李国栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeekSelectorCell : UICollectionViewCell

@property (nonatomic, strong) Week *week;

@end

NS_ASSUME_NONNULL_END
