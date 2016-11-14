//
//  ViewController.m
//  Layer-1
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "UIImage+Mask/UIImage+Mask.h"

@interface ViewController ()

@property (nonatomic,strong) DrawView *drawView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatImageView];
    [self creatDrawView];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 50, 50)];
    [button setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)creatDrawView
{
    self.drawView = [[DrawView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.drawView];
}

- (void)creatImageView
{
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.imageView];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DSC06324" ofType:@"JPG"];
    self.imageView.image = [UIImage imageWithContentsOfFile:path];
}

- (void)buttonAction:(UIButton *)sender
{
    UIGraphicsBeginImageContextWithOptions(self.imageView.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage *newImage = [UIImage maskWithImage:image withScale:1];
    UIImage *newImage = [self.imageView.image maskWithImage:image];
    self.imageView.image = newImage;
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
