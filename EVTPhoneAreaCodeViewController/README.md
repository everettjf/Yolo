# EVTPhoneAreaCodeViewController

Easy add Phone Area Code Select Feature to your apps.

![areacode](https://everettjf.github.io/stuff/areacode/areacode.gif)

## Usage

```oc
EVTPhoneAreaCodeViewController *vc = [[EVTPhoneAreaCodeViewController alloc]init];
vc.completion = ^(NSString *name, NSString *code){
    UIButton *b = sender;
    [b setTitle:[NSString stringWithFormat:@"+%@ %@",code,name] forState:UIControlStateNormal];
};
[self.navigationController pushViewController:vc animated:YES];

```


## Customize

You could customize lot of properties by giving the theme class.

```
@interface EVTPhoneAreaCodeViewControllerTheme : NSObject
// Background
@property (strong,nonatomic) UIColor *backgroundColor;

// Section
@property (strong,nonatomic) UIColor *sectionBackgroundColor;
@property (strong,nonatomic) UIColor *sectionForegroundColor;
@property (assign,nonatomic) CGFloat sectionHeight;
@property (strong,nonatomic) UIFont *sectionFont;

// Section Index
@property (strong,nonatomic) UIColor *sectionIndexBackgroundColor;
@property (strong,nonatomic) UIColor *sectionIndexColor;

// TableView
@property (strong,nonatomic) UIColor *tableViewBackgroundColor;
@property (strong,nonatomic) UIColor *tableViewSeparatorColor;

// ViewController
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *titleEn;

// SearchBar
@property (copy,nonatomic) NSString *searchBarPlaceHolder;
@property (copy,nonatomic) NSString *searchBarPlaceHolderEn;
@property (strong,nonatomic) UIColor *searchBarTintColor;
@property (strong,nonatomic) UIColor *searchBarBackgroundColor;

+ (EVTPhoneAreaCodeViewControllerTheme*)defaultTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)whiteTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)grayTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)greenTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)redTheme;
+ (EVTPhoneAreaCodeViewControllerTheme*)orangeTheme;

@end

EVTPhoneAreaCodeViewControllerTheme *theme = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
EVTPhoneAreaCodeViewController *vc = [[EVTPhoneAreaCodeViewController alloc]init];
vc.theme = theme;
//...

```


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

`>= iOS 7.0`

## Installation

EVTPhoneAreaCodeViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EVTPhoneAreaCodeViewController"
```

## Author

everettjf, everettjf@live.com

## License

EVTPhoneAreaCodeViewController is available under the MIT license. See the LICENSE file for more info.
