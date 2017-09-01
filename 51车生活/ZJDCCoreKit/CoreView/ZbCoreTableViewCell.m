//
//  ZJNewsBaseTableViewCell.m
//  Pods
//
//  Created by Prewindemon on 2017/5/5.
//
//

#import "ZbCoreTableViewCell.h"
#import "ZbCoreKit.h"
#import "Masonry.h"

/**
 快速生成UILabel
 
 @param fontSize 字体大小
 @param textColor 颜色
 @return Label实例
 */
UILabel *quickUILabel(CGFloat fontSize, UIColor *textColor, UIView *superView)
{
    UILabel *label = [UILabel new];
    label.font = Default_Font(fontSize);
    label.textColor = textColor;
    if (superView) {
        [superView addSubview: label];
    }
    return label;
}

/**
 快速生成UIImageView

 @return UIImageView实例
 */
UIImageView *quickUIImageView(UIView *superView){
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    if (superView) {
        [superView addSubview: imageView];
    }
    return imageView;
}


@interface ZbCoreTableViewCell (){
    //顶部分割线
    UIView *topSpliteLineView;
    
    //底部分割线
    UIView *bottomSpliteLineView;
}

@end

@implementation ZbCoreTableViewCell

+ (void)load{
//    [self hook_swizzleSelector: @selector(contentView) withSelector: @selector(zjnews_contentView)];
}

#pragma mark 初始化init

/**
 初始化Cell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle: style reuseIdentifier: reuseIdentifier]) {
        [self initZbCore_BaseTableViewCellBaseView];
        [self initZbCore_BaseTableViewCellMasonry];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return self;
}


/**
 *  初始化基本控件
 */
- (void)initZbCore_BaseTableViewCellBaseView{
    self.splitLineColor = [UIColor grayColor];
}
/**
 *  初始化约束
 */
- (void)initZbCore_BaseTableViewCellMasonry{
    
    topSpliteLineView = [self.contentView zbcore_drawLine: self.splitLineColor masBlock:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0.f);
        make.height.mas_equalTo(self.topSplitLineHeight);
    }];
    
    bottomSpliteLineView = [self.contentView zbcore_drawLine: self.splitLineColor masBlock:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0.f);
        make.height.mas_equalTo(self.bottomSplitLineHeight);
    }];
    
    [self.contentView addSubview: self.zbcore_contentView];
    [self.zbcore_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.f);
        make.top.mas_equalTo(topSpliteLineView.mas_bottom);
        make.bottom.mas_equalTo(bottomSpliteLineView.mas_top);
    }];
}

#pragma mark Getter/Setter方法

- (UIView *)zbcore_contentView{
    if (!_zbcore_contentView) {
        _zbcore_contentView = [UIView new];
        _zbcore_contentView.backgroundColor = [UIColor clearColor];
    }
    return _zbcore_contentView;
}

- (void)setTopSplitLineHeight:(CGFloat)topSplitLineHeight{
    _topSplitLineHeight = topSplitLineHeight;
    if (_topSplitLineHeight) {
        [topSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_topSplitLineHeight);
        }];
    }
}
- (void)setBottomSplitLineHeight:(CGFloat)bottomSplitLineHeight{
    _bottomSplitLineHeight = bottomSplitLineHeight;
    if (bottomSpliteLineView) {
        [bottomSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(bottomSplitLineHeight);
        }];
    }
}

- (void)setSplitLineMargin:(CGFloat)splitLineMargin{
    _splitLineMargin = splitLineMargin;
    if (_topSplitLineHeight) {
        [topSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(splitLineMargin);
            make.right.mas_equalTo(-splitLineMargin);
        }];
    }
    if (bottomSpliteLineView) {
        [bottomSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(splitLineMargin);
            make.right.mas_equalTo(-splitLineMargin);
        }];
    }
}

- (void)setSplitLineLeftMargin:(CGFloat)splitLineLeftMargin{
    _splitLineLeftMargin = splitLineLeftMargin;
    if (_topSplitLineHeight) {
        [topSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(splitLineLeftMargin);
        }];
    }
    if (bottomSpliteLineView) {
        [bottomSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(splitLineLeftMargin);
        }];
    }
}
- (void)setSplitLineRightMargin:(CGFloat)splitLineRightMargin{
    _splitLineRightMargin = splitLineRightMargin;
    if (_topSplitLineHeight) {
        [topSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-splitLineRightMargin);
        }];
    }
    if (bottomSpliteLineView) {
        [bottomSpliteLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-splitLineRightMargin);
        }];
    }
}


- (void)setSplitLineColor:(UIColor *)splitLineColor{
    _splitLineColor = splitLineColor;
    topSpliteLineView.backgroundColor = splitLineColor;
    bottomSpliteLineView.backgroundColor = splitLineColor;
    self.backgroundColor = splitLineColor;
}

- (void)setMarkContent:(NSString *)markContent{
    _markContent = markContent;
    NSAssert(self.markLabel, @"未给【markLabel】赋值");
    if (![self.markLabel.text length]) {
        return;
    }
    if (![self.markLabel.attributedText length]) {
        self.markLabel.attributedText = [[NSMutableAttributedString alloc] initWithString: self.markLabel.text];
    }
    
    NSMutableAttributedString *textAttrString = [self handleAttributedString: [self.markLabel.attributedText mutableCopy] markContent: markContent];
    
    self.markLabel.attributedText = textAttrString;
    self.markLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}


- (void)setMarkContents:(NSArray *)markContents{
    _markContents = markContents;
    NSAssert(self.markLabel, @"未给【markLabel】赋值");
    if (![markContents count]) {
        return;
    }
    if (![self.markLabel.text length]) {
        return;
    }
    if (![self.markLabel.attributedText length]) {
        self.markLabel.attributedText = [[NSMutableAttributedString alloc] initWithString: self.markLabel.text];
    }
    NSMutableAttributedString *textAttrString = [self.markLabel.attributedText mutableCopy];
    
    for (NSString *markContent in markContents) {
        textAttrString = [self handleAttributedString: [textAttrString mutableCopy] markContent: markContent];
    }
    self.markLabel.attributedText = textAttrString;
    self.markLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

@synthesize markColor = _markColor;
- (UIColor *)markColor{
    if (!_markColor) {
        _markColor = [UIColor redColor];
    }
    return _markColor;
}
- (void)setMarkColor:(UIColor *)markColor{
    _markColor = markColor;
    if ([self.markContents count]) {
        self.markContents = self.markContents;
    }
    if ([self.markContent length]) {
        self.markContent = self.markContent;
    }
}



#pragma mark privateMehtod
/**
 高亮textAttr的关键字
 
 @param textAttrString 需要高亮的String
 @param markContent 关键字
 @return 处理后的String
 */
- (NSMutableAttributedString *)handleAttributedString: (NSMutableAttributedString *)textAttrString markContent: (NSString *)markContent;{
    if (![markContent length]) {
        return textAttrString;
    }
    if (![self.markLabel.attributedText length]) {
        return textAttrString;
    }
    //查找关键字并进行标注变色
    NSRange range = [self.markLabel.text rangeOfString: markContent options: NSCaseInsensitiveSearch | NSRegularExpressionSearch];
    
    while (range.location != NSNotFound) {
        [textAttrString addAttribute:NSForegroundColorAttributeName value: self.markColor range: range];
        range = [self.markLabel.text rangeOfString: markContent
                                           options: NSCaseInsensitiveSearch | NSRegularExpressionSearch
                                             range: NSMakeRange(range.location + range.length, self.markLabel.text.length - (range.location + range.length))];
    }
    return textAttrString;
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    if (state == UITableViewCellStateShowingDeleteConfirmationMask) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (UIView *subView in self.subviews) {
                if ([NSStringFromClass([subView class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
                    for (UIView *actionButton in subView.subviews) {
                        [actionButton mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(self.topSplitLineHeight);
                            make.left.mas_equalTo(actionButton.zbcore_x);
                            make.bottom.mas_equalTo(- self.bottomSplitLineHeight);
                            make.width.mas_equalTo(actionButton.zbcore_width);
                        }];
                        
                    }
                    UIView *backView = [[UIView alloc] initWithFrame: CGRectMake(-_ScreenWidth / 2, 0, _ScreenWidth, subView.zbcore_height)];
                    backView.backgroundColor = self.contentView.backgroundColor;
                    [subView insertSubview: backView atIndex: 0];
                    
                    
                    
                    subView.layer.masksToBounds = NO;
                    
                    UIView *topLineView = [[UIView alloc] initWithFrame: CGRectMake(-_ScreenWidth / 2, 0, _ScreenWidth * 2, self.topSplitLineHeight)];
                    topLineView.backgroundColor = self.splitLineColor;
                    [subView addSubview: topLineView];
                    [subView bringSubviewToFront: topLineView];
                    
                    UIView *bottomLineView = [[UIView alloc] initWithFrame: CGRectMake(-_ScreenWidth / 2, subView.zbcore_height - self.bottomSplitLineHeight, _ScreenWidth * 2, self.bottomSplitLineHeight)];
                    bottomLineView.backgroundColor = self.splitLineColor;
                    [subView addSubview: bottomLineView];
                    [subView bringSubviewToFront: bottomLineView];
                    
                }
            }
        });
    }
}

//button 已经展示出来button, 将要关闭的时候调用
//- (void)didTransitionToState:(UITableViewCellStateMask)state {
//
//    NSLog(@"%s, %d", __FUNCTION__, __LINE__);
//}

@end
