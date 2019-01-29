//
//  ViewController.m
//  JHTapTextViewDemo
//
//  Created by HaoCold on 2019/1/29.
//  Copyright © 2019 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "JHTapTextView.h"
#import "Okidoki.h"

#define kShowMessage(msg) \
[[[UIAlertView alloc] initWithTitle:@"文本点击" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];

@interface ViewController ()<JHTapTextViewDelegate>
@property (nonatomic,  strong) JHTapTextView *textView1;
@property (nonatomic,  strong) JHTapTextView *textView2;
@property (nonatomic,  strong) JHTapTextView *textView3;
@property (nonatomic,  strong) JHTapTextView *textView4;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"可点击文本";
    [self xjh_setupViews];
}

#pragma mark -------------------------------------视图-------------------------------------------

- (void)xjh_setupViews
{
    [self.view addSubview:self.textView1];
    [self.view addSubview:self.textView2];
    [self.view addSubview:self.textView3];
    [self.view addSubview:self.textView4];
    
    _textView1.frame = CGRectMake(10, 100, CGRectGetWidth(self.view.frame)-20, 10);
    _textView1.autoWidth = YES;
    _textView1.autoHeight = YES; // Default is 'YES'
    _textView1.text = @"双十一，剁手季！查看详情~";
    _textView1.okidoki
    .attributedSubstring(@"查看详情",[UIColor yellowColor]);
    
    [_textView1 addTapTexts:@[@"查看详情"] callback:^(NSString *text, NSRange range) {
        NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
        kShowMessage(msg)
        NSLog(@"%@",msg);
    }];
    
    
    //=================
    _textView2.frame = CGRectMake(10, 150, CGRectGetWidth(self.view.frame)-20, 100);
    _textView2.text = @""
    "秋夕\n"
    "【作者】杜牧 【朝代】唐\n"
    "银烛秋光冷画屏，轻罗小扇扑流萤。\n"
    "天阶夜色凉如水，坐看牵牛织女星。\n"
    "译文😋\n"
    "在秋夜里烛光映照着画屏，手拿着小罗扇扑打萤火虫。夜色里的石阶清凉如冷水，静坐寝宫凝视牛郎织女星。";

    _textView2.okidoki
    .attributedSubstring(@"杜牧",[UIColor redColor])
    .attributedSubstring(@"唐",[UIColor greenColor])
    .attributedSubstring(@"织女星",[UIColor blueColor]);

    // 最后一个 "织女星" 也能点击
    [_textView2 addTapTexts:@[@"杜牧",@"唐",@"织女星",@"😋"] callback:^(NSString *text, NSRange range) {
        NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
        kShowMessage(msg)
        NSLog(@"%@",msg);
    }];
    
    
    //=================
    _textView3.frame = CGRectMake(10, 300, CGRectGetWidth(self.view.frame)-20, 10);
    _textView3.text = @"双十二，保肾季！点击查看，让你睡得安心~";
    _textView3.tapDelegate = self;
    _textView3.okidoki
    .attributedSubstring(@"点击查看",[UIColor cyanColor]);
    
    [_textView3 addTapTexts:@[@"点击查看"]];
    
    //=================
    _textView4.frame = CGRectMake(10, 350, CGRectGetWidth(self.view.frame)-20, 10);
    _textView4.text = @"庆除夕，迎新春！点击抢红包，只有一次机会";
    _textView4.tapDelegate = self;
    _textView4.okidoki
    .attributedSubstring(@"抢红包",[UIColor redColor]);
    
    [_textView4 addTapTexts:@[@"抢红包"]];

}

- (JHTapTextView *)setupTapTextView
{
    JHTapTextView *textView = [[JHTapTextView alloc] init];
    textView.textColor = [UIColor blackColor];
    textView.backgroundColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:14];
    textView.textAlignment = NSTextAlignmentLeft;
    return textView;
}

#pragma mark -------------------------------------事件-------------------------------------------

#pragma mark --- JHTapTextViewDelegate

- (void)tapTextView:(JHTapTextView *)tapTextView didClickText:(NSString *)text range:(NSRange)range
{
    NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
    kShowMessage(msg)
    NSLog(@"%@",msg);
    
    if (tapTextView == _textView4) {
        [tapTextView removeAllTapText];
        tapTextView.okidoki
        .attributedSubstring(@"抢红包",[UIColor blackColor]);
    }
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (JHTapTextView *)textView1{
    if (!_textView1) {
        _textView1 = [self setupTapTextView];
    }
    return _textView1;
}

- (JHTapTextView *)textView2{
    if (!_textView2) {
        _textView2 = [self setupTapTextView];
    }
    return _textView2;
}

- (JHTapTextView *)textView3{
    if (!_textView3) {
        _textView3 = [self setupTapTextView];
    }
    return _textView3;
}

- (JHTapTextView *)textView4{
    if (!_textView4) {
        _textView4 = [self setupTapTextView];
    }
    return _textView4;
}

@end
