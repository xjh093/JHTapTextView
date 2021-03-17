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

![image](https://github.com/xjh093/GIF/blob/master/gif/JHTapTextView.gif)

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
    /*
     在 UITableViewCell 中使用 JHTapTextView 时，滑动列表时，当手指是在 JHTapTextView 内时，会触发这个代理事件
     可进行如下判断
     
     If you use `JHTapTextView` in `UITableViewCell`,When you dragging the `UITableView`,
     if you finger is in the bounds of `JHTapTextView`, it will invoke this method,
     so you can do like this:
    */
    
    if (text.length) {
        // your code
        // 点击了某个文字时
    }
    else {
         BOOL flag = self.tableView.isDragging;
         if (!flag) {
             // 处理cell点击事件
             // do something about `UITableViewCell` click
         }
    }
}

- (UITableView *)tableView{
    UIView *tableView = self.superview;
    while (tableView) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            break;
        }
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
```




# Logs

### 2021-03-17
- if you add `JHTapTextView` to a `UIScrollView`, and the `UIScrollView` add a `UITapGestureRecognizer`, you should set `tap.cancelsTouchesInView = NO;` to cancel delay. 

### 2020-03-26
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

