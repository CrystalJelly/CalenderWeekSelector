//
//  Month.h
//  dateTest
//
//  Created by 李国栋 on 2019/5/9.
//  Copyright © 2019 李国栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Week.h"


@interface Month : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableArray<Week *> *weeks;


@end


