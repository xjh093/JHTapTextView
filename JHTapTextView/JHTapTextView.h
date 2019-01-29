//
//  JHTapTextView.h
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

#import <UIKit/UIKit.h>

@class JHTapTextView;

typedef void(^JHTapTextBlock)(NSString *text, NSRange range);

@protocol JHTapTextViewDelegate <NSObject>

- (void)tapTextView:(JHTapTextView *)tapTextView didClickText:(NSString *)text range:(NSRange)range;

@end

/**
 A subclass of UITextView with text clickable.
 */
@interface JHTapTextView : UITextView

@property (nonatomic,    weak) id<JHTapTextViewDelegate>tapDelegate;

/**
 'YES' is default.
 */
@property (nonatomic,  assign) BOOL  autoHeight;

/**
 'NO' is default.
 */
@property (nonatomic,  assign) BOOL  autoWidth;

/**
 Use block.
 Call this method before 'setText:'
 */
- (void)addTapTexts:(NSArray *)texts callback:(JHTapTextBlock)callback;

/**
 You should set the 'tapDelegate' when call this method before or after.
 Call this method before 'setText:'
 */
- (void)addTapTexts:(NSArray *)texts;

/**
 Remove text clickable.
 */
- (void)removeTapText:(NSArray *)texts;

/**
 Remove all text clickable.
 */
- (void)removeAllTapText;

@end

