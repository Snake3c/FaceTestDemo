//
//  MainViewController.m
//  FaceTestDemo
//
//  Created by cc on 15/9/28.
//  Copyright © 2015年 Snake. All rights reserved.
//

#import "MainViewController.h"
#import "FaceppAPI.h"
#import "UIView+AutoLayout.h"
#define blue [UIColor colorWithRed:19/255.0 green:47/255.0 blue:133/255.0 alpha:1]


@interface MainViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic ,weak) UIImageView *imageVIew;
@property (nonatomic ,weak) UIButton *photoBtn;
@property (nonatomic ,weak) UIButton *cameraBtn;
@property (nonatomic ,weak) UILabel *label;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Search";
    [self setupUI];
    
}


-(void)setupUI {
    
    //image
    UIImageView *imageView = [[UIImageView alloc]initForAutoLayout];
    [imageView setImage:[UIImage imageNamed:@"back"]];
    self.imageVIew = imageView;
    [self.view addSubview:imageView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageVIew attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageVIew attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:-50]];
    [self.imageVIew addConstraint:[NSLayoutConstraint constraintWithItem:self.imageVIew attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:280]];
    [self.imageVIew addConstraint:[NSLayoutConstraint constraintWithItem:self.imageVIew attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:360]];
    
    //photo
    UIButton *btn1 = [[UIButton alloc]initForAutoLayout];
    [btn1 setTitle:@"选择相册" forState:UIControlStateNormal];
    [btn1 setTitleColor:blue forState:UIControlStateNormal];
    self.photoBtn = btn1;
    [btn1 addTarget:self action:@selector(selectPhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [self.photoBtn sizeToFit];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:-100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:250]];
  
    //camera
    UIButton *btn2 = [[UIButton alloc]initForAutoLayout];
    [btn2 setTitle:@"选择相机" forState:UIControlStateNormal];
    [btn2 setTitleColor:blue forState:UIControlStateNormal];
    self.cameraBtn = btn2;
    [btn2 addTarget:self action:@selector(selectCameClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    [self.cameraBtn sizeToFit];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:250]];
    
    //label
    UILabel *label = [[UILabel alloc]initForAutoLayout];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    self.label = label;
    [self.view addSubview:self.label];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:200]];
    [self.label addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:300]];
    [self.label addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20]];
    
    
}

#pragma mark 相册

- (void)selectPhotoClick {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    UIImagePickerController *picker = [UIImagePickerController new];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark 相机

- (void)selectCameClick {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    UIImagePickerController *picker = [UIImagePickerController new];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark Picker代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    image = [self fixOrientation:image];
    
    //开始检测
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    //detection/detect	检测一张照片中的人脸信息（脸部位置、年龄、种族、性别等等）
    FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:data];
    
    //获取性别,年龄
    
    NSDictionary *attributeDict = result.content[@"face"][0][@"attribute"];
    NSString *ageValue = attributeDict[@"age"][@"value"];
    NSString *sexValue = [attributeDict[@"gender"][@"value"] isEqualToString:@"Male"] ? @"男性" : @"女性";
    self.label.text = [NSString stringWithFormat:@"年龄:%@  是一位:%@",ageValue ,sexValue];
    
    UIGraphicsBeginImageContextWithOptions( image.size, NO, 0);
    [image drawAtPoint:CGPointZero];
    UIGraphicsEndImageContext();
    
    CGFloat scale = image.size.width / [UIScreen mainScreen].bounds.size.width;
    
    
    [self.imageVIew autoSetDimension: ALDimensionWidth toSize:image.size.width / scale];
    [self.imageVIew autoSetDimension:ALDimensionHeight toSize:image.size.height / scale];
    self.imageVIew.image = image;

    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 方向校正


- (UIImage*)fixOrientation:(UIImage*)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    

    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage* img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
