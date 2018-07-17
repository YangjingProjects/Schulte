//
//  LevelListController.m
//  Schulte
//
//  Created by YangJing on 2018/7/16.
//  Copyright © 2018年 YangJing. All rights reserved.
//

#import "LevelListController.h"
#import "TestController.h"

#import "LevelListCell.h"

@interface LevelListController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LevelListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
    [self addSubview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = kRGBA(28, 28, 28, 1);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_back"] style:UIBarButtonItemStyleDone target:self action:@selector(popAction:)];
}

//MARK: - data
- (void)getData {
    self.dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 2; i < 10; i++) {
        LevelModel *model = [[LevelModel alloc] init];
        model.level = i;
        [self.dataArray addObject:model];
    }
}

//MARK: - private methods
- (void)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: - collectionview datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LevelListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LevelListCellId forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.contentView.layer.cornerRadius = 8;
    return cell;
}

//MARK: - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LevelModel *model = self.dataArray[indexPath.row];
    
    TestController *subVC = [[TestController alloc] init];
    subVC.model = model;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:subVC] animated:YES completion:nil];
}

- (void)addSubview {
    self.navigationItem.title = @"挑战等级";
    
    [self.view addSubview:self.collectionView];
}

//MARK: - getter
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(kScreenWidth-80, 100);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.minimumLineSpacing = 15;
        _layout.minimumInteritemSpacing = 15;
        _layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = kRGBA(28, 28, 28, 1);
        [_collectionView registerClass:[LevelListCell class] forCellWithReuseIdentifier:LevelListCellId];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
