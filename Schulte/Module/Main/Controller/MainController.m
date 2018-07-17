//
//  MainController.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "MainController.h"
#import "LevelListController.h"
#import "RuleController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kRGBA(28, 28, 28, 1);
    
    [self addSubview];
    [self animationAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

//MARK: - private methods
- (void)levelListAction:(id)sender {
    [self.navigationController pushViewController:[LevelListController new] animated:YES];
}

- (void)ruleAction:(id)sender {
    [self presentViewController:[[RuleController alloc] init] animated:YES completion:nil];
}

- (void)animationAction {
    UIView *coverView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kRGBA(28, 28, 28, 1);
        view;
    });
    [self.view addSubview:coverView];
    coverView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);

    UILabel *coverLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont fontWithName:@"Georgia-Bold" size:25];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"Schulte";
        label;
    });
    [coverView addSubview:coverLabel];
    [coverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(coverView.mas_centerX);
        make.centerY.equalTo(coverView.mas_centerY);
    }];
    
    CGFloat textWidth = [@"Schulte" boundingRectWithSize:CGSizeMake(MAXFLOAT, [UIFont fontWithName:@"Georgia-Bold" size:25].lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont fontWithName:@"Georgia-Bold" size:25]} context:nil].size.width;
    
    UIView *lineView1 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [coverView addSubview:lineView1];
    lineView1.frame = CGRectMake((kScreenWidth - textWidth)/2-20, 0, 5, 0);
    
    UIView *lineView2 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [coverView addSubview:lineView2];
    lineView2.frame = CGRectMake(kScreenWidth - (kScreenWidth - textWidth)/2+20, kScreenHeight, 5, 0);
    
    UIView *lineView3 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [coverView addSubview:lineView3];
    lineView3.frame = CGRectMake(0, (kScreenHeight-[UIFont fontWithName:@"Georgia-Bold" size:25].lineHeight)/2-80, 0, 5);
    
    UIView *lineView4 = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [coverView addSubview:lineView4];
    lineView4.frame = CGRectMake(kScreenWidth, kScreenHeight - (kScreenHeight-[UIFont fontWithName:@"Georgia-Bold" size:25].lineHeight)/2+80, 0, 5);

    [UIView animateWithDuration:2 animations:^{
        lineView1.frame = CGRectMake((kScreenWidth - textWidth)/2-20, 0, 5, kScreenHeight);
        lineView2.frame = CGRectMake(kScreenWidth - (kScreenWidth - textWidth)/2+20, 0, 5, kScreenHeight);
        lineView3.frame = CGRectMake(0, (kScreenHeight-[UIFont fontWithName:@"Georgia-Bold" size:25].lineHeight)/2-80, kScreenWidth, 5);
        lineView4.frame = CGRectMake(0, kScreenHeight - (kScreenHeight-[UIFont fontWithName:@"Georgia-Bold" size:25].lineHeight)/2+80, kScreenWidth, 5);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            coverView.alpha = 0;
            
        } completion:^(BOOL finished) {
            [coverView removeFromSuperview];
            
        }];
    }];
}

- (void)addSubview {
    
    UIButton *ruleBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"规则" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ruleAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont fontWithName:@"Georgia" size:13];
        btn;
    });
    [self.view addSubview:ruleBtn];
    ruleBtn.frame = CGRectMake(kScreenWidth-44-6, 20+(kiPhoneX ? 22 : 0), 44, 44);
    
    UIButton *startBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 8;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = kRGBA(36, 139, 68, 1).CGColor;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"开始挑战" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kRGBA(28, 28, 28, 1)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kRGBA(36, 139, 68, 1)] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:17];
        btn;
    });
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, 50));
    }];
    [startBtn addTarget:self action:@selector(levelListAction:) forControlEvents:UIControlEventTouchUpInside];
}

@end
