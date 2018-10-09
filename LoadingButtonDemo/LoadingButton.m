//
//  LoadingButton.m
//  LoadingButtonDemo
//
//  Created by mr.zhou on 2018/10/8.
//  Copyright © 2018 mr.zhou. All rights reserved.
//

#import "LoadingButton.h"

@implementation LoadingButton

- (instancetype)initWithFrame:(CGRect)frame  {
    if (self = [super initWithFrame:frame]) {
        _animateLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width / 2, frame.size.height/2) radius:self.frame.size.height / 2 - 7 startAngle:M_PI/2 endAngle:M_PI * 2 clockwise:YES];
        _animateLayer.path = path.CGPath;
        _animateLayer.lineWidth = 3;
        _animateLayer.strokeColor = [UIColor whiteColor].CGColor;
        _animateLayer.fillColor = [UIColor clearColor].CGColor;
        _animateLayer.frame = self.bounds;
        [self.layer addSublayer:_animateLayer];
        
        _insideAnimateLayer = [[CAShapeLayer alloc] init];
        UIBezierPath *inPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width / 2, frame.size.height/2) radius:self.frame.size.height / 2 - 14 startAngle:M_PI/2 endAngle:M_PI * 2 clockwise:YES];
        _insideAnimateLayer.path = inPath.CGPath;
        _insideAnimateLayer.lineWidth = 3;
        _insideAnimateLayer.strokeColor = [UIColor whiteColor].CGColor;
        _insideAnimateLayer.fillColor = [UIColor clearColor].CGColor;
        _insideAnimateLayer.frame = self.bounds;
        [self.layer addSublayer:_insideAnimateLayer];
        
        _animateLayer.hidden = YES;
        _insideAnimateLayer.hidden = YES;
        
        _masksLayer = [CAShapeLayer layer];
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        [maskPath moveToPoint:(CGPointMake(0, 10))];
        [maskPath addArcWithCenter:(CGPointMake(10, 10)) radius:10 startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width - 10, 0))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - 10, 10)) radius:10 startAngle:M_PI * 3 / 2 endAngle:M_PI * 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width, self.frame.size.height - 10))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - 10, self.frame.size.height - 10)) radius:10 startAngle:M_PI * 2 endAngle:M_PI / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(10, self.frame.size.height ))];
        [maskPath addArcWithCenter:(CGPointMake(10, self.frame.size.height - 10)) radius:10 startAngle:M_PI / 2 endAngle:M_PI clockwise:YES];
        [maskPath closePath];
        _masksLayer.path = maskPath.CGPath;
        self.layer.mask = _masksLayer;
        
        
    }
    return self;
}

- (void)beginAnimate {
    self.animating = YES;
    self.lasttitle = self.currentTitle;
    [self setTitle:@"" forState:(UIControlStateNormal)];
    

    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkAction)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopAnimate {
    self.animating = NO;
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(reset)];
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}
- (void)reset {
    _animateLayer.hidden = YES;
    _insideAnimateLayer.hidden = YES;
    [self.animateLayer removeAllAnimations];
    [self.insideAnimateLayer removeAllAnimations];
    self.enabled = NO;
    CGFloat radius = self.frame.size.height / 2;
    if (self.widthOffset <= 0) {
        if (self.heightOffset  <= 0) {
            
            // 开始转圈
            [_link invalidate];
            self.enabled = YES;

            [self setTitle:self.lasttitle forState:(UIControlStateNormal)];
            return;
        }
        self.heightOffset -= (self.frame.size.height - 20) / 2 / 5.0;
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        [maskPath moveToPoint:(CGPointMake(0, 10 + self.heightOffset))];
        [maskPath addArcWithCenter:(CGPointMake(10 + self.heightOffset, 10+ self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width - 10 - self.heightOffset, 0))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - 10- self.heightOffset, 10+ self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI * 3 / 2 endAngle:M_PI * 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width, self.frame.size.height - 10- self.heightOffset))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - 10- self.heightOffset, self.frame.size.height - 10- self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI * 2 endAngle:M_PI / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(10, self.frame.size.height ))];
        [maskPath addArcWithCenter:(CGPointMake(10 + self.heightOffset, self.frame.size.height - 10- self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI / 2 endAngle:M_PI clockwise:YES];
        [maskPath closePath];
        _masksLayer.path = maskPath.CGPath;

        
    } else {
        self.widthOffset -= (self.frame.size.width - 20) / 2 / 15.0;

        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        [maskPath moveToPoint:(CGPointMake(radius + self.widthOffset, 0))];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width - radius - self.widthOffset, 0))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - self.frame.size.height / 2 - self.widthOffset, self.frame.size.height / 2)) radius:self.frame.size.height / 2 startAngle:M_PI * 3 / 2 endAngle:M_PI / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.height / 2 + self.widthOffset, self.frame.size.height))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.height / 2 + self.widthOffset, self.frame.size.height / 2)) radius:self.frame.size.height / 2 startAngle:M_PI / 2 endAngle:M_PI * 3 / 2 clockwise:YES];
        [maskPath closePath];
        _masksLayer.path = maskPath.CGPath;

    }
    
}


- (void)linkAction {
    self.enabled = NO;
    CGFloat radius = self.frame.size.height / 2;
    if (self.heightOffset  >= (self.frame.size.height - 20)/2) {
        if (self.widthOffset >= self.frame.size.width / 2 - self.frame.size.height / 2) {
            
            // 开始转圈
            [_link invalidate];
            _animateLayer.hidden = NO;
            _insideAnimateLayer.hidden = NO;
            self.enabled = YES;

            CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
            
            CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
            keyAnima.values = @[@(0),@(1),@(0)];
            keyAnima.keyTimes = @[@(0),@(0.5),@(1)];
            keyAnima.duration = 2;
            keyAnima.removedOnCompletion = NO;
            keyAnima.fillMode = kCAFillModeForwards;
//            CABasicAnimation *growAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            growAnima.fromValue = @(0.1);
//            growAnima.toValue = @(1.0);
            
            
            
//            CABasicAnimation *shrinkAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//            growAnima.fromValue = @(1.0);
//            growAnima.toValue = @(0.1);
            
            CAKeyframeAnimation *keyAnima1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            keyAnima1.values = @[@(0),@(M_PI * 2),@(M_PI * 4)];
            keyAnima1.keyTimes = @[@(0),@(0.5),@(1)];
            keyAnima1.duration = 2;
            keyAnima1.removedOnCompletion = NO;
            keyAnima1.fillMode = kCAFillModeForwards;
            
            self.outAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            self.outAnimation .toValue = @(M_PI  * 2);
            self.outAnimation .fillMode = kCAFillModeForwards;
            self.outAnimation .removedOnCompletion = NO;
            self.outAnimation .duration = 2;
//            self.outAnimation .repeatCount = 100;
            
            group.animations = @[keyAnima, keyAnima1];
            group.removedOnCompletion = NO;
            group.fillMode = kCAFillModeForwards;
            group.duration = 2;
            group.repeatCount = 100;
            
            [self.animateLayer addAnimation:group  forKey:nil];
            
            self.inAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            self.inAnimation .toValue = @(-M_PI  * 2);
            self.inAnimation .fillMode = kCAFillModeForwards;
            self.inAnimation .removedOnCompletion = NO;
            self.inAnimation .duration = 0.6;
            self.inAnimation .repeatCount = 100;
            [self.insideAnimateLayer addAnimation:self.inAnimation  forKey:nil];

            return;
        }
        self.widthOffset += (self.frame.size.width - 20) / 2 / 10.0;
        if (self.widthOffset >= self.frame.size.width / 2 - self.frame.size.height / 2) {
            self.widthOffset = self.frame.size.width / 2 - self.frame.size.height / 2;
        }
        
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        [maskPath moveToPoint:(CGPointMake(radius + self.widthOffset, 0))];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width - radius - self.widthOffset, 0))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - self.frame.size.height / 2 - self.widthOffset, self.frame.size.height / 2)) radius:self.frame.size.height / 2 startAngle:M_PI * 3 / 2 endAngle:M_PI / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.height / 2 + self.widthOffset, self.frame.size.height))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.height / 2 + self.widthOffset, self.frame.size.height / 2)) radius:self.frame.size.height / 2 startAngle:M_PI / 2 endAngle:M_PI * 3 / 2 clockwise:YES];
        [maskPath closePath];
        _masksLayer.path = maskPath.CGPath;
        
    } else {
        self.heightOffset += (self.frame.size.height - 20) / 2 / 5.0;
        if (self.heightOffset >= (self.frame.size.height - 20) / 2 ) {
            self.heightOffset = (self.frame.size.height - 20) / 2;
        }
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        [maskPath moveToPoint:(CGPointMake(0, 10 + self.heightOffset))];
        [maskPath addArcWithCenter:(CGPointMake(10 + self.heightOffset, 10+ self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width - 10 - self.heightOffset, 0))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - 10- self.heightOffset, 10+ self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI * 3 / 2 endAngle:M_PI * 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(self.frame.size.width, self.frame.size.height - 10- self.heightOffset))];
        [maskPath addArcWithCenter:(CGPointMake(self.frame.size.width - 10- self.heightOffset, self.frame.size.height - 10- self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI * 2 endAngle:M_PI / 2 clockwise:YES];
        [maskPath addLineToPoint:(CGPointMake(10, self.frame.size.height ))];
        [maskPath addArcWithCenter:(CGPointMake(10 + self.heightOffset, self.frame.size.height - 10- self.heightOffset)) radius:10+ self.heightOffset startAngle:M_PI / 2 endAngle:M_PI clockwise:YES];
        [maskPath closePath];
        _masksLayer.path = maskPath.CGPath;
    }
    

}

@end
