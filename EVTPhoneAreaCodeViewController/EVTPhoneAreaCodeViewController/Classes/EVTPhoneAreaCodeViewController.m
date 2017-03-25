//
//  AreaCodeViewController.m
//  AreaCodeViewController
//
//  Created by everettjf on 16/6/8.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "EVTPhoneAreaCodeViewController.h"

#define UIColorFromRGBA(rgbValue, alphaValue) \
    [UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
    blue:((float)(rgbValue & 0x0000FF))/255.0 \
    alpha:alphaValue]

@implementation EVTPhoneAreaCodeViewControllerTheme

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backgroundColor = UIColorFromRGBA(0x8ee2d3, 1.0);
        _sectionBackgroundColor = UIColorFromRGBA(0xf0f7f6, 1.0);
        _sectionForegroundColor = UIColorFromRGBA(0x808080, 1.0);
        _tableViewBackgroundColor = UIColorFromRGBA(0xf0f7f6, 1.0);
        _tableViewSeparatorColor = UIColorFromRGBA(0xc8c7cc, 1.0);
        _sectionIndexBackgroundColor = [UIColor clearColor];
        _sectionIndexColor = UIColorFromRGBA(0x6a6677, 1.0);
        _searchBarTintColor = [UIColor whiteColor];
        _searchBarBackgroundColor = UIColorFromRGBA(0xf0f7f6, 1.0);
        
        _sectionFont = [UIFont systemFontOfSize:18];
        _sectionHeight = 25;
        _title = @"选择分区号";
        _titleEn = @"Choose Area Code";
        _searchBarPlaceHolder = @"搜索";
        _searchBarPlaceHolderEn = @"Search";
    }
    return self;
}

+ (EVTPhoneAreaCodeViewControllerTheme *)defaultTheme{
    EVTPhoneAreaCodeViewControllerTheme *t = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
    return t;
}

+ (EVTPhoneAreaCodeViewControllerTheme *)whiteTheme{
    EVTPhoneAreaCodeViewControllerTheme *t = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
    t.backgroundColor = [UIColor whiteColor];
    t.sectionBackgroundColor = [UIColor whiteColor];
    t.sectionForegroundColor = [UIColor blackColor];
    t.tableViewBackgroundColor = [UIColor whiteColor];
    t.tableViewSeparatorColor = [UIColor blackColor];
    t.sectionIndexBackgroundColor = [UIColor clearColor];
    t.sectionIndexColor = [UIColor blackColor];
    t.searchBarTintColor = [UIColor whiteColor];
    t.searchBarBackgroundColor = [UIColor whiteColor];
    
    return t;
}

+ (EVTPhoneAreaCodeViewControllerTheme *)grayTheme{
    EVTPhoneAreaCodeViewControllerTheme *t = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
    t.backgroundColor = [UIColor grayColor];
    t.sectionBackgroundColor = [UIColor grayColor];
    t.sectionForegroundColor = [UIColor whiteColor];
    t.tableViewBackgroundColor = [UIColor grayColor];
    t.tableViewSeparatorColor = [UIColor blackColor];
    t.sectionIndexBackgroundColor = [UIColor clearColor];
    t.sectionIndexColor = [UIColor grayColor];
    t.searchBarTintColor = [UIColor grayColor];
    t.searchBarBackgroundColor = [UIColor whiteColor];
    
    return t;
}

+ (EVTPhoneAreaCodeViewControllerTheme *)greenTheme{
    EVTPhoneAreaCodeViewControllerTheme *t = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
    t.backgroundColor = [UIColor greenColor];
    t.sectionBackgroundColor = [UIColor greenColor];
    t.sectionForegroundColor = [UIColor whiteColor];
    t.tableViewBackgroundColor = [UIColor greenColor];
    t.tableViewSeparatorColor = [UIColor blackColor];
    t.sectionIndexBackgroundColor = [UIColor clearColor];
    t.sectionIndexColor = [UIColor greenColor];
    t.searchBarTintColor = [UIColor greenColor];
    t.searchBarBackgroundColor = [UIColor whiteColor];
    
    return t;
}

+ (EVTPhoneAreaCodeViewControllerTheme *)redTheme{
    EVTPhoneAreaCodeViewControllerTheme *t = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
    t.backgroundColor = [UIColor redColor];
    t.sectionBackgroundColor = [UIColor redColor];
    t.sectionForegroundColor = [UIColor whiteColor];
    t.tableViewBackgroundColor = [UIColor redColor];
    t.tableViewSeparatorColor = [UIColor blackColor];
    t.sectionIndexBackgroundColor = [UIColor clearColor];
    t.sectionIndexColor = [UIColor redColor];
    t.searchBarTintColor = [UIColor redColor];
    t.searchBarBackgroundColor = [UIColor whiteColor];
    
    return t;
}

+ (EVTPhoneAreaCodeViewControllerTheme *)orangeTheme{
    EVTPhoneAreaCodeViewControllerTheme *t = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
    t.backgroundColor = [UIColor orangeColor];
    t.sectionBackgroundColor = [UIColor orangeColor];
    t.sectionForegroundColor = [UIColor whiteColor];
    t.tableViewBackgroundColor = [UIColor orangeColor];
    t.tableViewSeparatorColor = [UIColor blackColor];
    t.sectionIndexBackgroundColor = [UIColor clearColor];
    t.sectionIndexColor = [UIColor orangeColor];
    t.searchBarTintColor = [UIColor orangeColor];
    t.searchBarBackgroundColor = [UIColor whiteColor];
    
    return t;
}

@end

@interface EVTPhoneAreaCode: NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *alphaName;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *firstChar;
@end
@implementation EVTPhoneAreaCode
@end

@interface EVTPhoneAreaCodeViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray<NSMutableArray<EVTPhoneAreaCode*>*> *_codes;
    NSMutableArray<NSString*> *_sectionTitles;
    
    NSMutableArray<EVTPhoneAreaCode*> *_allCodes;
    
    UITableView *_tableView;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UISearchDisplayController *_searchDisplayController;
#pragma clang diagnostic pop
    NSArray<EVTPhoneAreaCode*> *_filterCodes;
}

@end

@implementation EVTPhoneAreaCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(!_theme)_theme = [[EVTPhoneAreaCodeViewControllerTheme alloc]init];
    
    self.navigationItem.title = _localeEn?_theme.titleEn:_theme.title;
    
    _codes = [NSMutableArray new];
    _sectionTitles = [NSMutableArray new];
    _filterCodes = @[];
    
    [self _setupUI];
    
    [self _loadData];
}

- (void)_setupUI{
    self.view.backgroundColor = _theme.backgroundColor;
    
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.placeholder = _localeEn?_theme.searchBarPlaceHolderEn:_theme.searchBarPlaceHolder;
    searchBar.delegate = self;
    searchBar.translucent = YES;
    searchBar.barTintColor = _theme.searchBarTintColor;
    searchBar.backgroundColor = _theme.searchBarBackgroundColor;
    searchBar.tintColor = UIColorFromRGBA(0x808080, 1.0);
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:searchBar];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
#pragma clang diagnostic pop
    [_searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.delegate = self;
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.allowsSelection = YES;
    
    if(_theme.sectionIndexBackgroundColor)
        _tableView.sectionIndexBackgroundColor = _theme.sectionIndexBackgroundColor;
    if(_theme.sectionIndexColor)
        _tableView.sectionIndexColor = _theme.sectionIndexColor;
    if(_theme.tableViewBackgroundColor)
        _tableView.backgroundColor = _theme.tableViewBackgroundColor;
    [self.view addSubview:_tableView];
    
    // layout
    searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:searchBar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
}


- (NSString *)_readFromFrameworkBundle:(NSString*)resource{
    NSBundle *bundle = [NSBundle bundleForClass:[EVTPhoneAreaCode class]];
    NSURL *bundlePath = [bundle URLForResource:NSStringFromClass([EVTPhoneAreaCodeViewController class]) withExtension:@"bundle"];
    NSURL *codePath = [bundlePath URLByAppendingPathComponent:resource];
    NSError *error;
    NSString *codeSource = [NSString stringWithContentsOfURL:codePath encoding:NSUTF8StringEncoding error:&error];
    if(error)return nil;
    return codeSource;
}
- (NSString *)_readFromMainBundle:(NSString*)resource{
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *codePath = [[bundle resourceURL] URLByAppendingPathComponent:resource];
    NSError *error;
    NSString *codeSource = [NSString stringWithContentsOfURL:codePath encoding:NSUTF8StringEncoding error:&error];
    if(error)return nil;
    return codeSource;
}

- (void)_loadData{
    NSString *resName = @"evt_phone_area_code_zh.txt";
    if(_localeEn) resName = @"evt_phone_area_code_en.txt";
    
    NSString *codeSource = [self _readFromFrameworkBundle:resName];
    if(!codeSource) codeSource = [self _readFromMainBundle:resName];
    if(!codeSource) return;
    
    NSArray<NSString*> *lines = [codeSource componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    _allCodes = [NSMutableArray new];
    
    NSMutableDictionary * dicts = [NSMutableDictionary new];
    for (NSString *line in lines) {
        NSArray<NSString*> *parts = [line componentsSeparatedByString:@"="];
        
        EVTPhoneAreaCode *code = [EVTPhoneAreaCode new];
        if(parts.count == 3){
            code.name = parts[0];
            code.alphaName = parts[1];
            code.code = parts[2];
        }else if(parts.count == 2){
            code.name = parts[0];
            code.alphaName = parts[0];
            code.code = parts[1];
        }else{
            continue;
        }
        
        code.firstChar = [code.alphaName substringToIndex:1];
        
        NSMutableArray *items = [dicts objectForKey:code.firstChar];
        if(!items) {
            items = [NSMutableArray new];
            [dicts setObject:items forKey:code.firstChar];
        }
        
        [items addObject:code];
        [_allCodes addObject:code];
    }
    
    _codes = [NSMutableArray new];
    for (NSString *firstChar in dicts) {
        [_codes addObject:[dicts objectForKey:firstChar]];
    }
    [_codes sortUsingComparator:^NSComparisonResult(NSMutableArray<EVTPhoneAreaCode*>*  _Nonnull obj1, NSMutableArray<EVTPhoneAreaCode*>*  _Nonnull obj2) {
        return [obj1.firstObject.firstChar compare:obj2.firstObject.firstChar];
    }];
    
    _sectionTitles = [NSMutableArray new];
    for (NSMutableArray<EVTPhoneAreaCode*> *code in _codes) {
        [_sectionTitles addObject:code.firstObject.firstChar];
    }
    
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == _tableView)
        return _theme.sectionHeight;
    return 0;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if(tableView == _tableView)
        return _sectionTitles;
    return @[];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == _tableView)
        return _sectionTitles[section];
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _tableView)
        return _codes.count;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _tableView){
        return _codes[section].count;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@ or alphaName contains[cd] %@",
                                  _searchDisplayController.searchBar.text,
                                  _searchDisplayController.searchBar.text
                                  ];
        _filterCodes = [_allCodes filteredArrayUsingPredicate:predicate];
        return _filterCodes.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if(tableView == _tableView){
        cell.textLabel.text = _codes[indexPath.section][indexPath.row].name;
    }else{
        cell.textLabel.text = _filterCodes[indexPath.row].name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // select
    EVTPhoneAreaCode *code;
    if(tableView == _tableView) code = _codes[indexPath.section][indexPath.row];
    else code = _filterCodes[indexPath.row];
    
    if(self.completion)
        self.completion(code.name,code.code);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _filterCodes = nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView != _tableView)
        return nil;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _theme.sectionHeight)];
    
    label.backgroundColor = _theme.sectionBackgroundColor;
    label.text = [NSString stringWithFormat:@"    %@", _sectionTitles[section]];
    label.font = _theme.sectionFont;
    label.textColor = _theme.sectionForegroundColor;
    return label;
}



@end
