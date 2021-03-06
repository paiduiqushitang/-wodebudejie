//
//  XMGLoginRegisterViewController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/15.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegisterView.h"
#import "XMGFastLoginView.h"

// 1.划分结构(顶部 中间 底部) // 2.一个结构一个结构
// 越复杂的界面 越要封装(复用)

/*
 屏幕适配:
 1.一个view从xib加载,需不需在重新固定尺寸 一定要在重新设置一下
 
 2.在viewDidLoad设置控件frame好不好,开发中一般在viewDidLayoutSubviews布局子控件
 */

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation XMGLoginRegisterViewController

// 点击关闭
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击注册
- (IBAction)clickRegister:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 平移中间view
    _leadCons.constant = _leadCons.constant == 0? -self.middleView.xmg_width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 创建登录view
    XMGLoginRegisterView *loginView = [XMGLoginRegisterView loginView];
    // 添加到中间的view
    [self.middleView addSubview:loginView];
    
    // 添加注册界面
    XMGLoginRegisterView *registerView = [XMGLoginRegisterView registerView];
    // 添加到中间的view
    [self.middleView addSubview:registerView];
    
    // 添加快速登录view
    XMGFastLoginView *fastLoginView = [XMGFastLoginView fastLoginView];
    // 添加到底部的view
    [self.bottomView addSubview:fastLoginView];
    
   
}

// viewDidLayoutSubviews:才会根据布局调整控件的尺寸
- (void)viewDidLayoutSubviews
{
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    XMGLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
    // 设置注册view
    XMGLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake( self.middleView.xmg_width * 0.5, 0,self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
    // 设置快速登录
    XMGFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
}

@end
