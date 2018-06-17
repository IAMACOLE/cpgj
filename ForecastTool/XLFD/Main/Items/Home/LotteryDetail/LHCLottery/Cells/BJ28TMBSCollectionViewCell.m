//
//  BJ28TMBSCollectionViewCell.m
//  Kingkong_ios
//
//  Created by qj-07-pc001 on 2017/8/17.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "BJ28TMBSCollectionViewCell.h"
#import "ToolBarTextField.h"
#import "KKLotteryDetailScrollView.h"
@interface BJ28TMBSCollectionViewCell()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_picker;
}

@property(nonatomic,strong)ToolBarTextField *stareTExtField;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end
@implementation BJ28TMBSCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-(void)setModel:(LHCLotteryModel *)model{
    _model = model;
    for (int i = 0; i<28; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.stareTExtField = [[ToolBarTextField alloc]init];
    [self.stareTExtField setInputView:[self picker]];
    [self addSubview:self.stareTExtField];
    self.countButton.layer.cornerRadius = 4;
//    self.countButton.backgroundColor = MCUIColorWithRGB(219, 80, 72, 1);
    [self.countButton setTitle:model.pl_name forState:UIControlStateNormal];
}
- (IBAction)countButtonClick:(id)sender {
    
    //因为弹出pickView的时候scrollView会下滑 所以在之前先把scrollEnabled置否 然后等到弹出结束后 在恢复
    UIViewController *vc = [MCTool getCurrentVC];
    KKLotteryDetailScrollView *detailScrollView  = nil;
    for(UIView *view in vc.view.subviews){
        if([view isKindOfClass:[KKLotteryDetailScrollView class]]){
            detailScrollView  = (KKLotteryDetailScrollView *)view;
            detailScrollView.scrollView.scrollEnabled = NO;
        }
    }
    [self.stareTExtField becomeFirstResponder];
    detailScrollView.scrollView.scrollEnabled = YES;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
#pragma mark -每一列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
    
}
#pragma mark -pickView的代理方法 //有bug
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataArray[row];

}
#pragma mark -选择某项
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.countButton setTitle:self.dataArray[row] forState:UIControlStateNormal];
    _model.pl_name = self.dataArray[row];
    [self.stareTExtField resignFirstResponder];
    
}
-(UIPickerView *)picker
{
    if (!_picker)
    {
        _picker = [[UIPickerView alloc]init];
        [_picker setDelegate:self];
        [_picker setDataSource:self];
    }
    return _picker;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
@end
