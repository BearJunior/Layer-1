//
//  MyQuartzView.m
//  Layer-1
//
//  Created by admin on 16/11/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MyQuartzView.h"

@implementation MyQuartzView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 先填充一个alpha只为1的白色矩形
    CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
    
    // 对于iOS坐标系，调整一下坐标系的表示，使得原点处于左下侧
    // 这样与我们平时在数学中用的坐标系可取得一致
    CGContextTranslateCTM(context, 0.0f, self.frame.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    // 创建一个三角Path
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 调用CGPathMoveToPoint来开启一个子Path
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, 0.0f, self.frame.size.height);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 0.0f, 0.0f);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, self.frame.size.width * 0.125f, 0.0f);
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, 0.0f, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    // 设置Path的混合模式：
    // kCGBlendModeDestinationIn表示：如果alpha为0,那么采用目标像素
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    // 这里主要设置该path的alpha值为0
    CGContextSetRGBFillColor(context, 0.0f, 0.0f, 0.0f, 0.0f);
    
    // 添加Path并绘制该Path
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    
    CGPathRelease(path);
}

@end
