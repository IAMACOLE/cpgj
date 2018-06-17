//
//  KKUserAvatarViewController.m
//  Kingkong_ios
//
//  Created by 222 on 2018/1/19.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKUserAvatarViewController.h"
#import <RSKImageCropper/RSKImageCropper.h>

@interface KKUserAvatarViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, RSKImageCropViewControllerDelegate>

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *takePhotoBtn;
@property (nonatomic, strong) UIButton *albumBtn;

@end

@implementation KKUserAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self basicSetting];
//    [self sendNetWorking];
    [self initUI];
}

#pragma mark - 系统代理

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *getImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    RSKImageCropViewController *imageCropViewController = [[RSKImageCropViewController alloc] initWithImage:getImg cropMode:RSKImageCropModeCircle];
    imageCropViewController.delegate = self;
    [self.navigationController pushViewController:imageCropViewController animated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle {
    self.imgView.image = croppedImage;
    [self sendNetworking_iconImageToServerWithImage:croppedImage];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图库的点击事件
- (void)libraryClicked {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"不能打开图库" cancle:nil];
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

#pragma mark 拍照按钮的点击事件
- (void)cameraClicked {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [MCView BSAlertController_oneOption_viewController:self message:@"不能打开相机" cancle:nil];
        return;
    }
    
    NSArray * availableMeidatypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    BOOL canTakePicture = NO;
    for (NSString * mediaType in availableMeidatypes) {
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            //支持拍照
            canTakePicture = YES;
            break;
        }
    }
    
    if (!canTakePicture) {
        [MCView BSAlertController_oneOption_viewController:self message:@"相机不可用" cancle:nil];
        return;
    }
    
    //创建图片选取控制器
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

#pragma mark - 基本设置
- (void)basicSetting {
    self.view.backgroundColor = MCUIColorLightGray;
    self.titleString = @"个人头像";
}

#pragma mark - 网络设置
- (void)sendNetworking_iconImageToServerWithImage:(UIImage *)image {
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",MCIP,@"user/edit-user-image"];
    [MCTool BSNetWork_post_uploadDataWithUrl:urlStr data:image andViewController:self success:^(id data) {
        NSString * image_url = data[@"image_url"];
        if (image_url == nil) {
            image_url = @"";
        }
        NSDictionary * userinfoDic = [MCTool BSGetObjectForKey:BSUserinfo];
        NSMutableDictionary * dictM = [NSMutableDictionary dictionaryWithDictionary:userinfoDic];
        [dictM setObject:image_url forKey:BSUserinfo_image_url];
        [MCTool BSSetObject:dictM forKey:BSUserinfo];
        [MCView BSMBProgressHUD_onlyTextWithView:self.view andText:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        });
    } failure:^(NSError *error) {
        [self isShow404View];
    }];
}

#pragma mark - 配置UI
- (void)initUI {
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(self.imgView.mas_width);
    }];
    
    UIView *markView = [UIView new];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0.5;
    [self.view addSubview:markView];
    markView.frame = self.view.bounds;
    
    [self.view addSubview:self.takePhotoBtn];
    [self.view addSubview:self.albumBtn];
    [self.albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-70);
        make.bottom.equalTo(self.view).offset(-40);
        make.height.mas_equalTo(50);
    }];
    
    [self.takePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(70);
        make.right.equalTo(self.view).offset(-70);
        make.bottom.equalTo(self.albumBtn.mas_top).offset(-20);
        make.height.mas_equalTo(50);
    }];
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        NSURL *imgUrl = [NSURL URLWithString:[MCTool BSGetUserinfo_imageUrl]];
        [_imgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"myinfo"]];
    }
    return  _imgView;
}

- (UIButton *)takePhotoBtn {
    if (_takePhotoBtn == nil) {
        _takePhotoBtn = [[UIButton alloc] init];
        [_takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
        [_takePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_takePhotoBtn setBackgroundColor:[UIColor whiteColor]];
        _takePhotoBtn.layer.cornerRadius = 3;
        _takePhotoBtn.layer.masksToBounds = YES;
        _takePhotoBtn.layer.borderColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0].CGColor;
        _takePhotoBtn.layer.borderWidth = 1;
        [_takePhotoBtn addTarget:self action:@selector(cameraClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takePhotoBtn;
}

- (UIButton *)albumBtn {
    if (_albumBtn == nil) {
        _albumBtn = [[UIButton alloc] init];
        [_albumBtn setTitle:@"从手机相册选择" forState:UIControlStateNormal];
        [_albumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_albumBtn setBackgroundColor:[UIColor whiteColor]];
        _albumBtn.layer.cornerRadius = 3;
        _albumBtn.layer.masksToBounds = YES;
        _albumBtn.layer.borderColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0].CGColor;
        _albumBtn.layer.borderWidth = 1;
        [_albumBtn addTarget:self action:@selector(libraryClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _albumBtn;
}

@end
