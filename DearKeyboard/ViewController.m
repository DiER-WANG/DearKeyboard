//
//  ViewController.m
//  DearKeyboard
//
//  Created by 王昌阳 on 2018/5/2.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "ViewController.h"
#import <APAddressBook.h>
#import "ColumnFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    if ([APAddressBook access] != APAddressBookAccessGranted) {
        @weakify(self);
        [[APAddressBook new]requestAccess:^(BOOL granted, NSError * _Nullable error) {
            @strongify(self);
            NSLog(@"xxx%@", self);
        }];
    }
    ColumnFlowLayout *layout = [[ColumnFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:cv];
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    cv.backgroundColor = [UIColor whiteColor];
    [cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    cv.delegate = self;
    cv.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark dataSource and delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = (indexPath.item % 2 ? [UIColor magentaColor] : [UIColor cyanColor]);
    return cell;
}

@end
