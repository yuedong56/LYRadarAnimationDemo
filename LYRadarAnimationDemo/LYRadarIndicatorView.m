//
//  LYRadarIndicatorView.m
//  LYRadarAnimationDemo
//
//  Created by yuedongkui on 2016/12/22.
//  Copyright © 2016年 LY. All rights reserved.
//

#define INDICATOR_ANGLE 120.0f

#import "LYRadarIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

@interface LYRadarIndicatorView ()
@property (nonatomic, assign) CGFloat radius;           //半径
@property (nonatomic, strong) NSColor *startColor;      //渐变开始颜色
@property (nonatomic, strong) NSColor *endColor;        //渐变结束颜色
@property (nonatomic, assign) CGFloat angle;            //渐变角度
@property (nonatomic, assign) BOOL clockwise;           //是否顺时针
@property (nonatomic, assign) CGPoint center;
@end


@implementation LYRadarIndicatorView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    
    self.startColor = [NSColor colorWithRed:0.4 green:0.6 blue:0.9 alpha:0.2];
    self.endColor = [NSColor colorWithRed:1 green:1 blue:1 alpha:0];

    self.radius = 500;
    self.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.clockwise = NO;
    self.angle = 100;
    
    const CGFloat *startColorComponents = CGColorGetComponents(self.startColor.CGColor); //RGB components
    const CGFloat *endColorComponents = CGColorGetComponents(self.endColor.CGColor); //RGB components
    
    CGFloat R, G, B, A;
    //多个小扇形构造渐变的大扇形
    for (int i = 0; i<= self.angle; i++) {
        CGFloat ratio = (self.clockwise?(self.angle -i):i)/self.angle;
        R = startColorComponents[0] - (startColorComponents[0] - endColorComponents[0])*ratio;
        G = startColorComponents[1] - (startColorComponents[1] - endColorComponents[1])*ratio;
        B = startColorComponents[2] - (startColorComponents[2] - endColorComponents[2])*ratio;
        A = startColorComponents[3] - (startColorComponents[3] - endColorComponents[3])*ratio;
        NSLog(@"RGBA: %f, %f, %f, %f", R, G, B, A);
        //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
        NSColor *aColor = [NSColor colorWithRed:R green:G blue:B alpha:A];
        
        CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
        CGContextSetLineWidth(context, 0);//线的宽度
        //以self.radius为半径围绕圆心画指定角度扇形
        CGContextMoveToPoint(context, self.center.x, self.center.y);
        CGContextAddArc(context, self.center.x, self.center.y, self.radius,  i * M_PI / 180, (i + (self.clockwise?-1:1)) * M_PI / 180, self.clockwise);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    }
    
    
    
    //画圆圈
    for (int i=0; i<10; i++) {
        NSColor *color = [NSColor colorWithWhite:0.3 alpha:0.5];
        [color set]; //设置线条颜色
        
        //    UIBezierPath* aPath = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 100, 50)];//矩形
        CGFloat r = 60 + i*60;
        NSBezierPath* aPath = [NSBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width/2-r, self.bounds.size.width/2-r, r*2, r*2)];//圆形
        
        aPath.lineWidth = 0.2;
        //    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
        //    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
        
        [aPath stroke];
    }
}

@end
























