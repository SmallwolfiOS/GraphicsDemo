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
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 100, 100)];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.layer.borderWidth = 0.5;
    imageView.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:imageView];
    imageView.image = image;
    
}

@end
