//
//  ScoreController.m
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "ScoreController.h"
#import "TestController.h"
#import "ScoreEntity+CoreDataClass.h"

@interface ScoreController ()

@end

@implementation ScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSubview];
    
    [ScoreEntity insertScoreWithLevel:self.model.level score:self.score userId:@"" complete:^(BOOL contextDidSave, NSError * _Nonnull error) {
    }];
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
- (void)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)restartAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)nextAction:(id)sender {
    if (self.model.level < 9) {
        for (UIViewController *superVC in self.navigationController.viewControllers) {
            if ([superVC isKindOfClass:[TestController class]]) {
                LevelModel *model = [[LevelModel alloc] init];
                if (self.model.level < 9) {
                    model.level = self.model.level+1;
                }
                [(TestController *)superVC setModel:model];
                [self.navigationController popToViewController:superVC animated:NO];

            }
        }
        
    } else {
        [self.navigationController popViewControllerAnimated:NO];

    }

}

- (void)addSubview {
    self.view.backgroundColor = kRGB(28, 28, 28);
    
    UIButton *closeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navbar_close_white"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:closeBtn];
    closeBtn.frame = CGRectMake(6, (20+kiPhoneX ? 22 : 0), 44, 44);
    
    UILabel *titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont fontWithName:@"Georgia-Bold" size:17];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
//        label.text = @"成绩：";
        label;
    });
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerY.equalTo(self.view.mas_centerY).offset(-80);
    }];
    
    UILabel *scoreLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont fontWithName:@"Georgia-Bold" size:52];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%.2f s", self.score];
        label;
    });
    [self.view addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(titleLabel.mas_bottom);
    }];
    
    UILabel *historyLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont fontWithName:@"Georgia-Bold" size:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        if (self.model.bestScore == 0) {
            label.text = @"最佳记录：__:__ s";

        } else {
            label.text = [NSString stringWithFormat:@"最佳记录：%.2f s", self.model.bestScore];

        }
        label;
    });
    [self.view addSubview:historyLabel];
    [historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(scoreLabel.mas_bottom).offset(40);
    }];
    
    if (self.model.level < 9) {
        UIButton *restartBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"再来一次" forState:UIControlStateNormal];
            btn.backgroundColor = kRGB(253, 105, 87);
            btn.layer.cornerRadius = 8;
            btn.titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:17];
            [btn addTarget:self action:@selector(restartAction:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        [self.view addSubview:restartBtn];
        [restartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_centerX).offset(-20);
            make.top.equalTo(historyLabel.mas_bottom).offset(80);
            make.size.mas_offset(CGSizeMake(120, 45));
        }];
        
        UIButton *nextBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"下一关" forState:UIControlStateNormal];
            btn.backgroundColor = kRGB(95, 174, 250);
            btn.layer.cornerRadius = 8;
            btn.titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:17];
            [btn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        [self.view addSubview:nextBtn];
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_centerX).offset(20);
            make.top.equalTo(historyLabel.mas_bottom).offset(80);
            make.size.mas_offset(CGSizeMake(120, 45));
        }];
        
    } else {
        UIButton *restartBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"再来一次" forState:UIControlStateNormal];
            btn.backgroundColor = kRGB(95, 174, 250);
            btn.layer.cornerRadius = 8;
            btn.titleLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:17];
            [btn addTarget:self action:@selector(restartAction:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        [self.view addSubview:restartBtn];
        [restartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(historyLabel.mas_bottom).offset(80);
            make.size.mas_offset(CGSizeMake(120, 45));
        }];
    }
   
}

@end
