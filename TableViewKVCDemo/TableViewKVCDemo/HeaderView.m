//
//  HeaderView.m
//  TableViewKVCDemo
//
//  Created by 朱佳男 on 2017/11/6.
//  Copyright © 2017年 ShangYuKeJi. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setThreeButton];
        [self setBottomLine];
    }
    return self;
}
- (void)setThreeButton{
    NSArray *titleArray = @[@"全部",@"区域",@"类型"];
    for (int i = 0; i <3; i ++) {
        CGFloat width = self.bounds.size.width/3.0f;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i *width, CGRectGetHeight(self.frame)-45, width, 45);
        [button setBackgroundColor:[UIColor whiteColor]];
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"sjx"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sjx_l"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        CGFloat imageViewWidth = 10;
        CGFloat labelWidth = 30;
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(0,0 + labelWidth,0,0 - labelWidth)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0,0 - imageViewWidth,0, 0 + imageViewWidth)];
        button.tag = i+1;
        
        [self addSubview:button];
    }
}
- (void)setBottomLine{
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-0.5, self.bounds.size.width, 0.5)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineV];
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    UITableView *tableView = (UITableView *)object;
    CGFloat tableViewOffsetY = tableView.contentOffset.y;
    if (tableViewOffsetY < 200-64-45) {
        self.frame = CGRectMake(0, -tableViewOffsetY, self.bounds.size.width, 200);
    }else{
        self.frame = CGRectMake(0, -(200-64-45), self.bounds.size.width, 200);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
