//
//  RuleController.m
//  Schulte
//
//  Created by YangJing on 2018/7/17.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "RuleController.h"
#import "CustomTransition.h"

@interface RuleController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *alertBackView;

@end

@implementation RuleController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalTransitionStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addSubview];
}

//MARK: - private methods
- (void)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addSubview {
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];

    self.alertBackView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        view.layer.cornerRadius = 8;
        view;
    });
    [self.view addSubview:self.alertBackView];
    [self.alertBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 30, 64, 30));
    }];
    
    UIButton *closeBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navbar_close"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.imageView.tintColor = kRGB(28, 28, 28);
        btn;
    });
    [self.alertBackView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.alertBackView.mas_right).offset(-5);
        make.top.equalTo(self.alertBackView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    UILabel *titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = kRGB(28, 28, 28);
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"规则";
        label;
    });
    [self.alertBackView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.alertBackView.mas_centerX);
        make.top.equalTo(self.alertBackView.mas_top).offset(20);
    }];
    
    UIView *lineView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = kRGB(28, 28, 28);
        view;
    });
    [self.alertBackView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertBackView.mas_left).offset(20);
        make.right.equalTo(self.alertBackView.mas_right).offset(-20);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(0.5);
    }];
    
    UITextView *descView = ({
        UITextView *view = [[UITextView alloc] init];
        view.textColor = kRGB(28, 28, 28);
        view.font = [UIFont systemFontOfSize:15];
        view.textAlignment = NSTextAlignmentLeft;
        view.backgroundColor = [UIColor clearColor];
        view.showsVerticalScrollIndicator = NO;
        view.editable = NO;
        view;
    });
    [self.alertBackView addSubview:descView];
    [descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertBackView.mas_left).offset(20);
        make.right.equalTo(self.alertBackView.mas_right).offset(-20);
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.bottom.equalTo(self.alertBackView.mas_bottom).offset(-20);
    }];
    
    NSString *test = @"每张表按字符顺序，迅速找全所有的字符。\n\n舒尔特表（Schulte Grid）通过动态的练习锻炼视神经末梢。心理学上用此表来研究和发展心理感知的速度，其中包括视觉定向搜索运动的速度。\n用来培养注意力集中、分配、控制能力；拓展视幅；加快视频；提高视觉的稳定性、辨别力、定向搜索能力。练习的时间越长，看表所需的时间会越短。随着练习的深入，眼球的末梢视觉能力提高，不仅初学者可以有效地拓展视幅，加快阅读节奏，锻炼眼睛快速认读；而且对于进入提高阶段之后，同时拓展纵横视幅，达到一目十行、一目一页非常有效。" ;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle.headIndent = 0.0f;//行首缩进
    CGFloat emptylen = [UIFont systemFontOfSize:15].pointSize * 2-10;
    paraStyle.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle.tailIndent = 0.0f;//行尾缩进
    paraStyle.lineSpacing = 5.0f;//行间距
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:test attributes:@{NSParagraphStyleAttributeName:paraStyle, NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    descView.attributedText = attrText;

}

//MARK: - transition delegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CustomTransition enlargeTransitionWithType:TransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CustomTransition enlargeTransitionWithType:TransitionTypeDismiss];
}


@end
