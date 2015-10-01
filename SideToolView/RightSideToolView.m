//
//  RightSideToolView.m
//  SuningEBuy
//
//  Created by liukun on 14-2-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "RightSideToolView.h"
#import "ImageAboveLabelButton.h"

#define CONTENT_WIDTH       75.0f

@interface RightSideToolView ()

@property (nonatomic,weak)UIView * contentView;

@end

@implementation RightSideToolView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:101/255.0 green:107/255.0 blue:111/255.9 alpha:1.0];
        
        //设置位置
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.frame = frame;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.frame = self.bounds;
        self.contentView = contentView;
        
        
        [self btnMake:@"首页"];
        [self btnMake:@"收藏"];
        [self btnMake:@"购物车"];
        [self btnMake:@"我"];
        [self btnMake:@"分类"];

        [self addSubview:contentView];
        
        [self addSubview:self.screenshotImageView];
    }
    return self;
}



- (void)btnMake:(NSString *)titleName
{
    ImageAboveLabelButton *btn = [ImageAboveLabelButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.contentView.subviews.count;
    
    [self.contentView addSubview:btn];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat top = 80;
    NSInteger count = self.contentView.subviews.count;
    for (int i=0; i < count; i++) {
        ImageAboveLabelButton *btn = self.contentView.subviews[i];
        btn.frame = CGRectMake(0, i * top, CONTENT_WIDTH, 60);
    }
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.frame = frame;
    self.contentView.frame = CGRectMake(0, (frame.size.height-count*top)/2, CONTENT_WIDTH, frame.size.height);
}




- (UIImageView *)screenshotImageView
{
    if (!_screenshotImageView) {
        _screenshotImageView = [[UIImageView alloc] init];
        _screenshotImageView.userInteractionEnabled = YES;
        _screenshotImageView.frame = self.bounds;
        _screenshotImageView.layer.shadowColor = [UIColor grayColor].CGColor;
        _screenshotImageView.layer.shadowOffset = CGSizeMake(2, 0);
        _screenshotImageView.layer.shadowOpacity = 0.5;
        _screenshotImageView.layer.shadowRadius = 3;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = _screenshotImageView.bounds;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_screenshotImageView addSubview:button];
    }
    return _screenshotImageView;
}

+ (instancetype)sharedInstance
{
    static RightSideToolView *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[RightSideToolView alloc] init];
    });
    return __instance;
}

- (void)buttonTapped:(id)sender
{
    NSInteger index = [sender tag];
    
    NSLog(@"%zd",index);

    [RightSideToolView hideWithCompletion:^{
        UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        
        tabBarVC.selectedIndex = index;
    }];
}

- (void)hide
{
    [RightSideToolView hideWithCompletion:nil];
}

+ (void)show
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CGSize size = window.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [RightSideToolView sharedInstance].screenshotImageView.image = viewImage;

    [window addSubview:[RightSideToolView sharedInstance]];
    
    [UIView animateWithDuration:0.3
                          delay:0.
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [RightSideToolView sharedInstance].screenshotImageView.transform = CGAffineTransformMakeTranslation(CONTENT_WIDTH, 0);
                         
                     } completion:NULL];
}

+ (void)hideWithCompletion:(void(^)(void))block
{
    [UIView animateWithDuration:0.3
                          delay:0.
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         [RightSideToolView sharedInstance].screenshotImageView.transform = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finish){
                         
                         [[RightSideToolView sharedInstance] removeFromSuperview];
                         
                         if (block) {
                             block();
                         }
                     }];
}

@end
