//
//  CustomAnimationView.h
//  MainProject
//
//  Created by 王文科 on 2020/4/5.
//  Copyright © 2020 王文科. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAnimationView : UIView

- (instancetype)initAnimationViewWithFrame:(CGRect)frame cornerRadius:(CGFloat)radius;

- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
