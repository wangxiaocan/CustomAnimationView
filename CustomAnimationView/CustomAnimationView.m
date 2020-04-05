//
//  CustomAnimationView.m
//  MainProject
//
//  Created by 王文科 on 2020/4/5.
//  Copyright © 2020 王文科. All rights reserved.
//

#import "CustomAnimationView.h"


#define CUS_ANI_SPEED   0.01

@interface CustomAnimationView()

@property (nonatomic, strong) UIBezierPath  *path;
@property (nonatomic, strong) CAShapeLayer  *shapeLayer;

@property (nonatomic, strong) NSTimer       *animateTimer;

@end

@implementation CustomAnimationView

- (instancetype)initAnimationViewWithFrame:(CGRect)frame cornerRadius:(CGFloat)radius{
    CustomAnimationView *view = [[CustomAnimationView alloc] initWithFrame:frame];
    [view setRadius:radius];
    return view;
}

- (void)setRadius:(CGFloat)radius{
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    _path = [UIBezierPath bezierPath];
        
    [_path moveToPoint:CGPointMake(viewWidth, radius)];
    [_path addLineToPoint:CGPointMake(viewWidth, viewHeight - radius)];
    
    //右下角
    [_path addQuadCurveToPoint:CGPointMake(viewWidth - radius, viewHeight) controlPoint:CGPointMake(viewWidth, viewHeight)];
    
    //左下角
    [_path addLineToPoint:CGPointMake(radius, viewHeight)];
    [_path addQuadCurveToPoint:CGPointMake(0, viewHeight - radius) controlPoint:CGPointMake(0, viewHeight)];
    
    //左上角
    [_path addLineToPoint:CGPointMake(0, radius)];
    [_path addQuadCurveToPoint:CGPointMake(radius, 0) controlPoint:CGPointMake(0, 0)];
    
    //右上角
    [_path addLineToPoint:CGPointMake(viewWidth - radius, 0)];
    [_path addQuadCurveToPoint:CGPointMake(viewWidth, radius) controlPoint:CGPointMake(viewWidth, 0)];
    
    [self createShapeLayer];
}
- (void)createShapeLayer{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    _shapeLayer.path = _path.CGPath;
    _shapeLayer.lineWidth = 4;
    _shapeLayer.fillColor = self.backgroundColor.CGColor;
    _shapeLayer.strokeColor = [UIColor redColor].CGColor;
    _shapeLayer.strokeEnd = 0;
    [self.layer addSublayer:_shapeLayer];
}


- (void)startAnimation{
    if (_animateTimer) {
        [_animateTimer invalidate];
        _animateTimer = nil;
    }
    [self restartAnimation];
}

- (void)restartAnimation{
    if (_shapeLayer) {
        [_shapeLayer removeFromSuperlayer];
        _shapeLayer = nil;
    }
    [self createShapeLayer];
    [self startShapeLayerAnimationi];
}

- (void)startShapeLayerAnimationi{
    if (_animateTimer) {
        [_animateTimer invalidate];
        _animateTimer = nil;
    }
    _animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(changeShapeLayerStroke) userInfo:nil repeats:YES];
}

- (void)changeShapeLayerStroke{
    CGFloat st = _shapeLayer.strokeStart;
    CGFloat sd = _shapeLayer.strokeEnd;
    if (st == 0 && sd - st < 0.1) {
        sd += CUS_ANI_SPEED;
    }else{
        st += CUS_ANI_SPEED;
        sd += CUS_ANI_SPEED;
    }
    if (st > 1.2) {
        [self restartAnimation];
        return;
    }
    _shapeLayer.strokeStart = st;
    _shapeLayer.strokeEnd = sd;
}



@end
