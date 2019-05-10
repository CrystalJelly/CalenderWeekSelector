//
//  CollectionReusableView.m
//  CalenderWeekSelector
//
//  Created by 李国栋 on 2019/5/10.
//  Copyright © 2019 李国栋. All rights reserved.
//

#import "CollectionReusableView.h"

@interface CollectionReusableView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CollectionReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - 200) / 2.0, 5, 200, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
