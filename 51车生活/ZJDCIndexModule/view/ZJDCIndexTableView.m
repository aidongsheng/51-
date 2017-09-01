//
//  ZJDCIndexTableView.m
//  Pods
//
//  Created by aidongsheng on 2017/8/30.
//
//

#import "ZJDCIndexTableView.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation ZJDCIndexTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.fd_debugLogEnabled = YES;
    }
    return self;
}

@end
