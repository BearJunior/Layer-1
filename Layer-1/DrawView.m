//
//  DrawView.m
//  Layer-1
//
//  Created by admin on 16/11/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DrawView.h"
#import "LineModel.h"

@interface DrawView ()

@property (nonatomic, strong) NSMutableArray *paths;
@property (nonatomic, strong) NSMutableArray *points;

/** 当前颜色*/
@property (nonatomic, strong) UIColor *lineColor;
/** 当前宽度*/
@property (nonatomic, assign) float lineWidth;

@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self prepareUI];
        self.paths = [NSMutableArray array];
        self.points = [NSMutableArray array];
        self.lineWidth = 11;
        self.lineColor = [UIColor redColor];
        self.cutPaths = [NSMutableArray array];
    }
    return self;
}

- (void)prepareUI
{
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(30, self.frame.size.height - 100, 150, 40)];
    [self addSubview:slider];
    slider.value = 0.5;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSArray *colors = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor]];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(230 + 50 * i, self.frame.size.height - 95, 30, 30)];
        [button setBackgroundColor:colors[i]];
        [self addSubview:button];
        [button addTarget:self action:@selector(chooseColor:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 15;
    }
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    for (LineModel *lineModel  in self.paths) {
        [self creatPathWithLineModel:lineModel];
    }
}

- (void)creatPathWithLineModel:(LineModel *)lineModel
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = lineModel.lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [lineModel.lineColor  set];
    NSArray *array = lineModel.points;
    [path moveToPoint:[[array[0] point] CGPointValue]];
    for (NSInteger i = 1; i < array.count ; i ++) {
        [path addLineToPoint:[[array[i] point] CGPointValue]];
    }
    [path stroke];
    
    [self.cutPaths addObject:path];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.points removeAllObjects];
    
    LineModel *linModel = [LineModel new];
    linModel.lineColor = self.lineColor;
    linModel.lineWidth = self.lineWidth;
    [self.paths addObject:linModel];
    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    PointModel *model = [PointModel new];
    model.point = [NSValue valueWithCGPoint:[touch locationInView:self]];
    LineModel *lineModel = [self.paths lastObject];
    [self.points addObject:model];
    lineModel.points = [NSArray arrayWithArray:self.points];
    [self setNeedsDisplay];
}


#pragma mark - 改变线段宽度
- (void)sliderValueChanged:(UISlider *)sender
{
    self.lineWidth = sender.value * 20 + 1;
}

#pragma mark - 改变颜色
- (void)chooseColor:(UIButton *)sender
{
    self.lineColor = sender.backgroundColor;
}

@end
