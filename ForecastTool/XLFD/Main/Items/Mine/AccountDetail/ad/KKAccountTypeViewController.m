//
//  KKAccountTypeViewController.m
//  Kingkong_ios
//
//  Created by hello on 2018/5/1.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKAccountTypeViewController.h"
#import "KKDetailTypeModel.h"

@interface KKAccountTypeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,weak)UIButton *clearButton;
@property(nonatomic,weak)UIButton *determineButton;
@property(nonatomic,weak)UIPickerView *pickerView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *typeArray;
@property(nonatomic,weak)UIView *lineView;
@property(nonatomic,strong)NSString *cellType;
@property(nonatomic,strong)NSString *cellSubType;

@end

@implementation KKAccountTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSMutableArray array];
    _typeArray = [NSMutableArray array];
    [self initView];

    [self requestAccountDetailType];
}

-(void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    [self clearButton];
    [self determineButton];
    [self lineView];
    [self pickerView];
    
    if (_titleArray.count > 0) {
       _cellType = [_titleArray objectAtIndex:0];
    }
}

-(UIButton *)clearButton{
    if (_clearButton == nil) {
        UIButton *clearButton = [[UIButton alloc]init];
        [clearButton setTitle:@"取消" forState:UIControlStateNormal];
        [clearButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [clearButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clickClearButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:clearButton];
        
        [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.view);
            make.height.equalTo(@60);
            make.width.equalTo(@60);
        }];

        _clearButton = clearButton;
    }
    return _clearButton;
}

-(UIButton *)determineButton{
    if (_determineButton == nil) {
        UIButton *determineButton = [[UIButton alloc]init];
        [determineButton setTitle:@"确定" forState:UIControlStateNormal];
        [determineButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [determineButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [determineButton addTarget:self action:@selector(clickDetermineButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:determineButton];
        
        [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.view);
            make.height.equalTo(@60);
            make.width.equalTo(@60);
        }];
        
        _determineButton = determineButton;
    }
    return _determineButton;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self.view addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.view);
            make.height.equalTo(@1);
            make.top.equalTo(_determineButton.mas_bottom);
        }];
        
        _lineView = lineView;
    }
    return _lineView;
}

-(UIPickerView *)pickerView{
    if (_pickerView == nil) {
        UIPickerView *pickerView = [[UIPickerView alloc]init];
        pickerView.showsSelectionIndicator = YES;
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self.view addSubview:pickerView];
        
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self.view);
            make.top.equalTo(_lineView.mas_bottom);
        }];
        
        _pickerView = pickerView;
    }
    return _pickerView;
}

#pragma mark -PickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (0 == component) {
        return _titleArray.count;
    }else{
        return _typeArray.count;
    }
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == component) {
        return [_titleArray objectAtIndex:row];
    }else{
        return [_typeArray objectAtIndex:row];
    }
}

//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (0 == component) {
        KKDetailTypeModel *dtm = [_titleArray objectAtIndex:row];
        _cellType = dtm.type_value;
        _typeArray = [NSMutableArray arrayWithArray:dtm.sub_type];
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
        _cellSubType = [[_typeArray objectAtIndex:0] objectForKey:@"type_value"];
    }else{
        _cellSubType = [[_typeArray objectAtIndex:row] objectForKey:@"type_value"];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return MCScreenWidth/2;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 60;
}



//  第component列第row行显示怎样的view(内容)
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth/2, 60)];
    
    if (0 == component) {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, MCScreenWidth/2-30, 60)];
        leftLabel.backgroundColor = [UIColor whiteColor];
        leftLabel.numberOfLines = 2;
        leftLabel.font = [UIFont systemFontOfSize:16];
        KKDetailTypeModel *dtm = [_titleArray objectAtIndex:row];
        leftLabel.text = dtm.type_name;
        [cellView addSubview:leftLabel];
    }else{
        UILabel *rigtLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MCScreenWidth/2-30, 60)];
        rigtLabel.backgroundColor = [UIColor whiteColor];
        rigtLabel.font = [UIFont systemFontOfSize:16];
        rigtLabel.numberOfLines = 2;
        rigtLabel.textAlignment = NSTextAlignmentRight;
        NSDictionary *dtsm = [_typeArray objectAtIndex:row];
        rigtLabel.text = [dtsm objectForKey:@"type_name"];
        [cellView addSubview:rigtLabel];
    }
    return cellView;
}



#pragma mark 点击事件
-(void)clickClearButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickDetermineButton{
    self.determineButtonClick(_cellType,_cellSubType);
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 请求帐户明细类型
- (void)requestAccountDetailType{
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"/v2/sys-config/get-flow-type"];
    [MCTool BSNetWork_postWithUrl:urlStr parameters:nil andViewController:self isShowHUD:YES isShowTabbar:NO success:^(id data) {
        _titleArray  =  [KKDetailTypeModel mj_objectArrayWithKeyValuesArray:data];
        KKDetailTypeModel *detailTypeModel  = [[KKDetailTypeModel alloc]init];
        detailTypeModel.type_name = @"全部";
        detailTypeModel.sub_type = @[@{@"type_name":@"全部",@"type_value":@""}];
        if (_titleArray.count > 0) {
           [_titleArray insertObject:detailTypeModel atIndex:0];
        }
       

        if (_titleArray.count > 0) {
            KKDetailTypeModel *dtm = [_titleArray objectAtIndex:0];
            _typeArray = [NSMutableArray arrayWithArray:dtm.sub_type];
            
            _cellType = dtm.type_value;
            _cellSubType = [[_typeArray objectAtIndex:0] objectForKey:@"type_value"];
        }
        [self.pickerView reloadAllComponents];
    } dislike:^(id data) {
    } failure:^(NSError *error) {
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"未获取可用数据，请稍后再试！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
