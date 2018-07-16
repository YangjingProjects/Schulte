//
//  TestController.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "TestController.h"
#import "TestCell.h"

@interface TestController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger currentNumber;

@property (nonatomic, assign) NSTimeInterval startTime;

@property (nonatomic, assign) NSTimeInterval stopTime;

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
    [self addSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = self.model.levelColor;
    
    [self addObserver:self forKeyPath:@"currentNumber" options:NSKeyValueObservingOptionNew context:nil];
    
    [self timerAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeObserver:self forKeyPath:@"currentNumber"];
}

//MARK: - data
- (void)getData {
    self.dataArray = [[NSMutableArray alloc] init];
    NSInteger count = self.model.levelSize.height*self.model.levelSize.width;
    for (NSInteger i = 1; i < count+1; i++) {
        TestModel *model = [[TestModel alloc] init];
        model.number = i;
        model.heighlightColor = self.model.levelColor;
        model.level = self.model.level;
        
        if (self.dataArray.count == 0) {
            [self.dataArray addObject:model];
            
        } else {
            [self.dataArray insertObject:model atIndex:random()%self.dataArray.count];

        }
    }
}

//MARK: - private methods
- (void)timerAnimation {
    self.collectionView.hidden = YES;
    
    UILabel *delayLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont systemFontOfSize:125];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"3";
        label;
    });
    [self.view addSubview:delayLabel];
    delayLabel.frame = CGRectMake(kScreenWidth/2-50, kScreenHeight/2-[UIFont systemFontOfSize:125].lineHeight/2, 100, [UIFont systemFontOfSize:125].lineHeight);
    delayLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
    delayLabel.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        delayLabel.transform = CGAffineTransformIdentity;
        delayLabel.alpha = 1;
        
    } completion:^(BOOL finished) {
        delayLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
        delayLabel.alpha = 0;
        delayLabel.text = @"2";
        
        [UIView animateWithDuration:1 animations:^{
            delayLabel.transform = CGAffineTransformIdentity;
            delayLabel.alpha = 1;
        } completion:^(BOOL finished) {
            delayLabel.transform = CGAffineTransformMakeScale(0.5, 0.5);
            delayLabel.alpha = 0;
            delayLabel.text = @"1";
            
            [UIView animateWithDuration:1 animations:^{
                delayLabel.transform = CGAffineTransformIdentity;
                delayLabel.alpha = 1;
                
            } completion:^(BOOL finished) {
                [delayLabel removeFromSuperview];
                self.collectionView.hidden = NO;
                [self timerStart];
                
            }];
        }];
    }];
}

- (void)timerStart {
    self.startTime = [[NSDate date] timeIntervalSince1970];
}

- (void)timerStop {
    self.stopTime = [[NSDate date] timeIntervalSince1970];
}

//MARK: - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentNumber"] && [object isEqual:self]) {
        NSInteger currentNumber = [change[NSKeyValueChangeNewKey] integerValue];
        if (currentNumber == self.model.levelSize.height*self.model.levelSize.width) {
            
            [self timerStop];
            
            NSLog(@"success %.2f", self.stopTime - self.startTime);
        }
    }
}

//MARK: - collectionview datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TestCellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.contentView.layer.cornerRadius = 6;
    return cell;
}

//MARK: - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TestModel *model = self.dataArray[indexPath.row];
    if (model.number != self.currentNumber+1) return;
    
    TestCell *cell = (TestCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.isSelected) return;
    cell.isSelected = !cell.isSelected;
    
    self.currentNumber = model.number;
}

- (void)addSubview {
    self.navigationItem.title = [NSString stringWithFormat:@"%ld x %ld", (long)self.model.level, (long)self.model.level];
    
    self.view.backgroundColor = kRGBA(28, 28, 28, 1);
    
    UILabel *topView = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"请按数字顺序依次点击";
        label;
    });
    [self.view addSubview:topView];
    topView.frame = CGRectMake(0, 64, kScreenWidth, 64);
    
    [self.view addSubview:self.collectionView];
    
    UILabel *bottomView = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0xffffff);
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"请按数字顺序依次点击";
        label;
    });
    [self.view addSubview:bottomView];
    bottomView.frame = CGRectMake(0, kScreenHeight-64, kScreenWidth, 64);
}

//MARK: - getter
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        CGFloat itemWidth;
        if (self.model.level > 7) {
            itemWidth = (kScreenWidth-40-5*(self.model.levelSize.width-1))/self.model.levelSize.width;
        } else {
            itemWidth = (kScreenWidth-40-10*(self.model.levelSize.width-1))/self.model.levelSize.width;
        }
        
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.minimumLineSpacing = self.model.level > 7 ? 5 : 10;
        _layout.minimumInteritemSpacing = self.model.level > 7 ? 5 : 10;
        _layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth) collectionViewLayout:self.layout];
        _collectionView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        _collectionView.backgroundColor = kRGBA(28, 28, 28, 1);
        [_collectionView registerClass:[TestCell class] forCellWithReuseIdentifier:TestCellID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
