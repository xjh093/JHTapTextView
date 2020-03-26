# JHTapTextView
Tap TextView，文本点击

---

# Version
Latest release version:

[1.2.0](https://github.com/xjh093/JHTapTextView/releases)

---

# Cocoapods
`pod "JHTapTextView"`

---

# What

![image](https://github.com/xjh093/JHTapTextView/blob/master/image.gif)

---

# Usage

```
    _textView.text = @""
    "秋夕\n"
    "【作者】杜牧 【朝代】唐\n"
    "银烛秋光冷画屏，轻罗小扇扑流萤。\n"
    "天阶夜色凉如水，坐看牵牛织女星。\n"
    "译文😋\n"
    "在秋夜里烛光映照着画屏，手拿着小罗扇扑打萤火虫。夜色里的石阶清凉如冷水，静坐寝宫凝视牛郎织女星。";
    
    _textView.okidoki
    .attributedSubstring(@"杜牧",[UIColor redColor])
    .attributedSubstring(@"唐",[UIColor greenColor])
    .attributedSubstring(@"织女星",[UIColor blueColor]);
    
    __weak typeof(self) wk = self;
    [_textView addTapTexts:@[@"杜牧",@"唐",@"织女星",@"😋"] callback:^(NSString *text, NSRange range) {
        
        NSString *msg = [NSString stringWithFormat:@"text:%@,range:%@",text,NSStringFromRange(range)];
        UIAlertController
        .jhAlertCtrl(@"文本点击", msg, @(1))
        .jh_addNormalAction(@"确定",^{
            
        })
        .jh_show(wk);
        
        NSLog(@"%@",msg);
    }];
    
#pragma mark --- JHTapTextViewDelegate
- (void)tapTextView:(JHTapTextView *)tapTextView didClickText:(NSString *)text range:(NSRange)range
{
    if (text.length) {
        // your code
        // 点击了某个文字时
    }
    else {
        // do other things
        // 未点击指定文字时，处理其他事件
    }
}
```
# Logs

### 2020-0326
- modify delegate method.

### 2019-09-19
- fix note "before setText:" -> "after setText:".

### 2019-04-03
- 1.fix bug.
- 2.add tap effect.

### 2019-01-29
- 1.add demo.
- 2.add delegate.

### 2019-01-28
- 1.upload.

---

# More detail in Demo :)

