//
//  ViewController.m
//  Layer-1
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

#import "MyQuartzView.h"

@interface ViewController ()
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@property (nonatomic, strong) UIView *layerView;

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
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"jpg"];
    self.imageView.image = [UIImage imageWithContentsOfFile:path];
}

- (void)buttonAction:(UIButton *)sender
{
    [self setup];
    //self.imageView.hidden = YES;
    self.drawView.hidden = YES;
}

- (void)setup
{

    CALayer *mask = [CALayer layer];
    mask.contents = self.imageView.image;
//    mask.pa
    
}

- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}


#pragma mark - 懒加载
- (UIView *)layerView
{
    if (!_layerView) {
        _layerView = [[UIView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:_layerView];
    }
    return _layerView;
}


- (void)setLayer1
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    //    self.layerView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
}


- (void)setLayer2
{
    
}

- (void)addSpriterImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer//set image
{
    layer.contents = (__bridge id)image.CGImage;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
