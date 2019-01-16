//
//  ViewController.m
//  GraphicsDemo
//
//  Created by 马海平 on 2019/1/13.
//  Copyright © 2019 马海平. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addButton];
    
    [self drawaCircle];
}
- (void)addButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 34, SCREEN_WIDTH, 50)];
//    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    button.backgroundColor = [UIColor yellowColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"这就是一个button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}
- (void)buttonClicked:(UIButton *)btn{
    NSLog(@"点击了button");
    [self functionGraphics];
}
- (void)functionGraphics{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, 100), YES, 0);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 100, 100)];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.layer.borderWidth = 0.5;
    imageView.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:imageView];
    imageView.image = image;
    
}
- (void)drawaCircle{
//    __weak typeof(self) weakSelf = self;
    CGRect frame = CGRectMake(200, 300, 100, 100);
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
//    imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imageView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);          /* 1.设置当前上下文中绘制的区域 */
        CGContextRef context = UIGraphicsGetCurrentContext();               /* 2.获取当前上下文 */
    
        CGContextSetLineWidth(context, 2);                                  /* 2.修改当前上下文的画笔颜色和宽度 */
        [[UIColor redColor] setStroke];                                     /* 设置填充的原色，填充边缘 */
        CGContextSaveGState(context);                                       /* 3.保存当前上下文的状态 */

        CGContextAddEllipseInRect(context, CGRectMake(0, 0, frame.size.width, frame.size.height));      /* 绘制一个圆 */
        CGContextSetLineWidth(context,  3);                                 /* 设置画笔颜色和宽度 */
        [[UIColor purpleColor] setStroke];
        CGContextStrokePath(context);                                       /* 开始绘制 */
        
        
        CGContextAddEllipseInRect(context, CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20));
        CGContextSetLineWidth(context, 10);
        [[UIColor orangeColor] setStroke];
        CGContextStrokePath(context);
        
        
        
        CGContextRestoreGState(context);                                    /* 恢复当前上下文的状态 */
        
        CGContextAddEllipseInRect(context, CGRectMake(20, 20, frame.size.width-40, frame.size.height-40));  /* 绘制一个圆 */
                                                                            /* 不设置画笔颜色和宽度，因为原本的上下文有颜色和宽度状态 */
        
        CGContextStrokePath(context);                                       /* 开始绘制 */

        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();      /* 获取图片要写在结束上下文之前，否则无法获取image */
        UIGraphicsEndImageContext();                                        /* 关闭上下文 */
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}
@end
