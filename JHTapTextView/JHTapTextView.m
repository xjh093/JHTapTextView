//
//  JHTapTextView.m
//  JHKit
//
//  Created by HaoCold on 2019/1/11.
//  Copyright © 2019 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2019 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JHTapTextView.h"
//!!!!:JHTapTextModel
@interface JHTapTextModel : NSObject
@property (nonatomic,    copy) NSString *text;
@property (nonatomic,  assign) NSRange  range;
@property (nonatomic,    copy) JHTapTextBlock textBlock;

@property (nonatomic,  strong) UIColor *color;
@property (nonatomic,  strong) UIFont *font;
@end
@implementation JHTapTextModel @end

//!!!!:JHTapTextView
@interface JHTapTextView()
@property (nonatomic,  strong) NSMutableArray *textArray;
@property (nonatomic,  strong) JHTapTextModel *model;
@end

@implementation JHTapTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.editable                          = NO;
        self.scrollEnabled                     = NO;
        self.textContainerInset                = UIEdgeInsetsZero;
        self.showsVerticalScrollIndicator      = NO;
        self.showsHorizontalScrollIndicator    = NO;
        self.textContainer.lineFragmentPadding = 0;
        self.selectable                        = NO;
        
        _autoHeight = YES;
        _autoWidth = NO;
        _textArray = @[].mutableCopy;
    }
    return self;
}

#pragma mark --- override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSUInteger location = [self characterIndexAtLocation:[touches.anyObject locationInView:self]];
    if (location == NSNotFound) {
        return [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSUInteger location = [self characterIndexAtLocation:[touches.anyObject locationInView:self]];
    if (location == NSNotFound) {
        return [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self shouldCallback];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self shouldCallback];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (_autoWidth && _autoHeight) {
        [self sizeToFit];
    }
    else if (_autoHeight) {
        CGSize size = [self sizeThatFits:self.bounds.size];
        CGRect frame = self.frame;
        frame.size.height = size.height;
        self.frame = frame;
    }
    else if (_autoWidth) {
        CGSize size = [self sizeThatFits:self.bounds.size];
        CGRect frame = self.frame;
        frame.size.width = size.width;
        self.frame = frame;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    // 64 point offset
    if (newSuperview) {
        UIView *hoderView = [newSuperview viewWithTag:20190403];
        if (!hoderView) {
            hoderView = [[UIView alloc] init];
            hoderView.tag = 20190403;
            [newSuperview addSubview:hoderView];
        }
    }
}

#pragma mark --- private

- (NSUInteger)characterIndexAtLocation:(CGPoint)point
{
    NSUInteger index = [self.layoutManager glyphIndexForPoint:point inTextContainer:self.textContainer];
    CGRect rect = [self.layoutManager boundingRectForGlyphRange:NSMakeRange(index, 1) inTextContainer:self.textContainer];
    
    JHTapTextModel *selectModel = nil;
    if (CGRectContainsPoint(rect, point)) {
        for (JHTapTextModel *model in _textArray) {
            if (index >= model.range.location && index < model.range.location + model.range.length) {
                selectModel = model;
                break;
            }
        }
    }
    
    if (_highlightedBackgroundColor) {
        [self changeTapTextBackgroundColor:self.backgroundColor type:0];
    }
    if (selectModel) {
        _model = selectModel;
        if (_highlightedBackgroundColor) {
            [self changeTapTextBackgroundColor:_highlightedBackgroundColor type:0];
        }
    }else{
        _model = nil;
    }
    
    return NSNotFound;
}

- (void)shouldCallback
{
    if (_model.textBlock) {
        _model.textBlock(_model.text, _model.range);
    }
    if (_model && _tapDelegate && [_tapDelegate respondsToSelector:@selector(tapTextView:didClickText:range:)]) {
        [_tapDelegate tapTextView:self didClickText:_model.text range:_model.range];
    }
    if (_highlightedBackgroundColor) {
        [self changeTapTextBackgroundColor:self.backgroundColor type:1];
    }
    _model = nil;
}

- (void)allRangeOftext:(NSString *)text inText:(NSString *)theText callback:(JHTapTextBlock)callback
{
    NSRange range = [theText rangeOfString:text];
    while (range.location != NSNotFound) {
        
        JHTapTextModel *model = [[JHTapTextModel alloc] init];
        model.text = text;
        model.range = range;
        model.textBlock = callback;
        
        [_textArray addObject:model];
        
        NSUInteger length = range.location + range.length;
        range = [theText rangeOfString:text options:kNilOptions range:NSMakeRange(length, theText.length - length)];
    }
}

- (void)changeTapTextBackgroundColor:(UIColor *)bgcolor type:(NSInteger)type
{
    if (bgcolor == nil) {
        bgcolor = [UIColor clearColor];
    }
    
    if (_model) {
        
        NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText?self.attributedText:[[NSAttributedString alloc] initWithString:self.text]];
        if (type == 0) {
            [mastring addAttribute:NSBackgroundColorAttributeName value:bgcolor range:_model.range];
        }else if (type == 1) {
            [mastring removeAttribute:NSBackgroundColorAttributeName range:_model.range];
        }
        
        self.attributedText = mastring;
    }
}

#pragma mark --- public

- (void)addTapTexts:(NSArray *)texts callback:(JHTapTextBlock)callback
{
    NSString *theText = self.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (texts && callback) {
            for (NSString *text in texts) {
                if (text.length == 0) {
                    continue;
                }
                [self allRangeOftext:text inText:theText callback:callback];
            }
        }
    });
}

- (void)addTapTexts:(NSArray *)texts
{
    NSString *theText = self.text;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (texts) {
            for (NSString *text in texts) {
                if (text.length == 0) {
                    continue;
                }
                [self allRangeOftext:text inText:theText callback:nil];
            }
        }
    });
}

- (void)removeTapText:(NSArray *)texts;
{
    NSMutableArray *marr = @[].mutableCopy;
    
    for (NSString *text in texts) {
        if (text.length == 0) {
            continue;
        }
        for (JHTapTextModel *model in _textArray) {
            if ([model.text isEqualToString:text]) {
                [marr addObject:model];
            }
        }
    }
    
    [_textArray removeObjectsInArray:marr];
}

- (void)removeAllTapText
{
    [_textArray removeAllObjects];
}

@end
