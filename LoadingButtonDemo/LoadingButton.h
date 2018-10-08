//
//  LoadingButton.h
//  LoadingButtonDemo
//
//  Created by mr.zhou on 2018/10/8.
//  Copyright © 2018 mr.zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingButton : UIButton

@property (strong, nonatomic) CAShapeLayer  *animateLayer;
@property (strong, nonatomic) CAShapeLayer  *insideAnimateLayer;


@property (strong, nonatomic) CAShapeLayer  *masksLayer;

- (void)beginAnimate;
- (void)stopAnimate;

@property (nonatomic, assign) CGFloat widthOffset;
@property (nonatomic, assign) CGFloat heightOffset;

@property (strong, nonatomic) CADisplayLink  *link;

@property (nonatomic, copy) NSString *lasttitle;

@property (strong, nonatomic) CABasicAnimation  *outAnimation;
@property (strong, nonatomic) CABasicAnimation  *inAnimation;

@property (nonatomic, assign) BOOL animating;



@end

NS_ASSUME_NONNULL_END
