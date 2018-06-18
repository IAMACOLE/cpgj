//
//  XXSamePeriodTableViewCell.m
//  ForecastTool
//
//  Created by hello on 2018/6/17.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "XXSamePeriodTableViewCell.h"
#import "XXSamePeriodCollectionViewCell.h"
@interface XXSamePeriodTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UIView *line;
@property(nonatomic,weak)UILabel *titleLabel;//标题
@property(nonatomic,weak)UILabel *timeLalbe;//时间
@property(nonatomic,weak)UICollectionView *collectionView;

@end

@implementation XXSamePeriodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = [UIColor whiteColor];
    [self line];
    
    [self titleLabel];
    [self timeLalbe];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
}

-(UIView *)line{
    if (_line == nil) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self);
        }];
        
        _line = line;
    }
    return _line;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.text = @"第2018089期";
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@5);
        }];
        
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)timeLalbe{
    if (_timeLalbe == nil) {
        UILabel *timeLalbe = [[UILabel alloc]init];
        timeLalbe.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
        timeLalbe.font = [UIFont systemFontOfSize:14];
        timeLalbe.text = @"2018-6-6 20:30:05";
        [self addSubview:timeLalbe];
        
        [timeLalbe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@5);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        _timeLalbe = timeLalbe;
    }
    return _timeLalbe;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XXSamePeriodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SamePeriodCollectionViewCell" forIndexPath:indexPath];
    cell.number = @"08";
    cell.cellHight = 30;
    return cell;
}
-(UICollectionView *)collectionView{
    if(_collectionView == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(30, 30);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = (MCScreenWidth - 30-30*10)/10;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 0, MCScreenWidth - 30, 30) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.scrollEnabled = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[XXSamePeriodCollectionViewCell class] forCellWithReuseIdentifier:@"SamePeriodCollectionViewCell"];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
