# EVTTabPageScrollView

**Not recommend to use, only for basic learn.**

---

Simple Tab Page

![demo](http://everettjf.github.io/images/extern/EVTTabPageScrollView.gif)

## Usage

```oc

UIView *view1 = [UIView new];
UIView *view2 = [UIView new];
UIView *view3 = [UIView new];
UIView *view4 = [UIView new];
UIView *view5 = [UIView new];

NSArray *pageItems = @[
                       [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"News" andTabView:view1],
                       [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"Tech" andTabView:view2],
                       [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"Life" andTabView:view3],
                       [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"Job" andTabView:view4],
                       [[EVTTabPageScrollViewPageItem alloc]initWithTabName:@"Fun" andTabView:view5],
                       ];
_pageScroll = [[EVTTabPageScrollView alloc]initWithPageItems:pageItems];

UIView *rootView = self.view;
[rootView addSubview:_pageScroll];
[_pageScroll mas_makeConstraints:^(MASConstraintMaker *make){
    make.top.equalTo(rootView.mas_top).offset(30);
    make.left.equalTo(rootView.mas_left);
    make.right.equalTo(rootView.mas_right);
    make.bottom.equalTo(rootView.mas_bottom);
}];

```

## Installation

EVTTabPageScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EVTTabPageScrollView"
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```oc
#import <Masonry.h>
#import <EVTTabPageScrollView.h>
```

## Author

everettjf, everettjf@live.com

## License

EVTTabPageScrollView is available under the MIT license. See the LICENSE file for more info.
