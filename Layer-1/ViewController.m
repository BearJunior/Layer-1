//
//  ViewController.m
//  Layer-1
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"


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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
