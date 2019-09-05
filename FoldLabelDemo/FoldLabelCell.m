//
//  FoldLabelCell.m
//  FoldLabelDemo
//
//  Created by Lee on 2019/9/1.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "FoldLabelCell.h"
#import <CoreText/CoreText.h>
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

static const NSInteger limitMaxLineCount = 3;

@interface FoldLabelCell ()
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//@property (nonatomic, copy) NSString *moreText;
@property (nonatomic, strong) NSString *contentString;
@property (weak, nonatomic) IBOutlet UIButton *foldButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foldButtonTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foldButtonHeight;
@end

@implementation FoldLabelCell

- (void)setModel:(FoldModel *)model {
    _model = model;
    self.topicLabel.text = model.title;
    self.contentLabel.text = model.content;
    BOOL isFold = [self shouldFoldContent:_contentLabel];
    if (isFold) {
        //折叠
        if (!model.isFold) {
            [self.foldButton setTitle:@"展开" forState: UIControlStateNormal];
            self.contentLabel.numberOfLines = limitMaxLineCount;
        } else {
            [self.foldButton setTitle:@"收起" forState: UIControlStateNormal];
            self.contentLabel.numberOfLines = 0;
        }
        self.foldButton.hidden = NO;
        self.foldButtonHeight.constant = 20;
        self.foldButtonTopMargin.constant = 10;
    } else {
        //不需要折叠
        self.contentLabel.numberOfLines = 0;
        self.foldButton.hidden = YES;
        self.foldButtonHeight.constant = 0;
        self.foldButtonTopMargin.constant = 0;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//点击按钮
- (IBAction)foldButtonClicked:(id)sender {
    if (self.showContentCallback) {
        self.showContentCallback();
    }
}

#pragma mark 是否需要折叠内容
- (BOOL)shouldFoldContent:(UILabel *)label {
    NSArray *lineStringArray = [self getSeparatedLinesFromLabelWidth:kScreenWidth - 30 text:label.text];
    if (lineStringArray.count > limitMaxLineCount) {
        return YES;
    }
    return NO;
}

#pragma mark 计算UILabel每一行显示的字符串
- (NSArray *)getSeparatedLinesFromLabelWidth:(CGFloat)labelWidth text:(NSString *)textStr {
    NSString *text = textStr;
    UIFont *font = _contentLabel.font;
    if (text == nil) {
        return nil;
    }
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:(NSString *)kCTFontAttributeName
                   value:(__bridge  id)myFont
                   range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,labelWidth,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,
                                       lineRange,
                                       kCTKernAttributeName,
                                       (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}
@end

