//
//  MainController.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "MainController.h"
#import "LevelListController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

//MARK: - private methods
- (void)levelListAction:(id)sender {
    [self.navigationController pushViewController:[LevelListController new] animated:YES];
}

- (void)addSubview {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = kRGBA(28, 28, 28, 1);
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont systemFontOfSize:17]};
    
    self.view.backgroundColor = kRGBA(28, 28, 28, 1);
    
    UIButton *startBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 8;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = kRGBA(36, 139, 68, 1).CGColor;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"开始挑战" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kRGBA(28, 28, 28, 1)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kRGBA(36, 139, 68, 1)] forState:UIControlStateHighlighted];
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
