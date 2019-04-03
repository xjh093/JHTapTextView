# JHTapTextView
Tap TextView，文本点击

---

# Version
Latest release version:

[1.1.0](https://github.com/xjh093/JHTapTextView/releases)

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
```
# Logs

### 2019-01-29
- 1.add demo.
- 2.add delegate.

### 2019-01-28
- 1.upload.

---

# More detail in Demo :)

