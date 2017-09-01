//
//  ZJNewsBaseTableViewCell.h
//  Pods
//
//  Created by Prewindemon on 2017/5/5.
//
//

#import <UIKit/UIKit.h>

/**
 快速生成UILabel

 @param fontSize 字体大小
 @param textColor 颜色
 @param superView 父视图
 @return Label实例
 */
UILabel *quickUILabel(CGFloat fontSize, UIColor *textColor, UIView *superView);


/**
 快速生成UIImageView
 
 @return UIImageView实例
 */
UIImageView *quickUIImageView(UIView *superView);


/**
 //ZbCoreTableViewCell的Identifier
 */
static NSString *ZbCoreTableViewCellIdentifier = @"com.zbjt.zbcore.ZbCoreTableViewCell";

@interface ZbCoreTableViewCell : UITableViewCell


/**
 代替contentView
 */
@property(nonatomic, strong)UIView *zbcore_contentView;

/**
 顶部分割线高度
 */
@property(nonatomic, assign)CGFloat topSplitLineHeight;

/**
 底部分割线高度
 */
@property(nonatomic, assign)CGFloat bottomSplitLineHeight;

/**
 底部分割线左右间距，默认0，如有重复设置，后设置的生效
 */
@property(nonatomic, assign)CGFloat splitLineLeftMargin;
@property(nonatomic, assign)CGFloat splitLineRightMargin;
@property(nonatomic, assign)CGFloat splitLineMargin;

/**
 分割线颜色
 */
@property(nonatomic, strong)UIColor *splitLineColor;


/**
 高亮Label
 */
@property(nonatomic, strong)UILabel *markLabel;

/**
 高亮颜色
 */
@property(nonatomic, strong)UIColor *markColor;

/**
 高亮单条内容
 */
@property(nonatomic, strong)NSString *markContent;

/**
 高亮多条内容
 */
@property(nonatomic, strong)NSArray *markContents;



@end
