//
//  ColumnFlowLayout.m
//  DearKeyboard
//
//  Created by 王昌阳 on 2018/6/8.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "ColumnFlowLayout.h"

@implementation ColumnFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    UICollectionView *cv = self.collectionView;
    
    CGFloat avaliableWidth = UIEdgeInsetsInsetRect(cv.bounds, cv.layoutMargins).size.width;
    CGFloat miniumWidth = 300;
    
    NSInteger maxNumColumns = (NSInteger)avaliableWidth/miniumWidth;
    CGFloat cellWidth = avaliableWidth/(CGFloat)maxNumColumns;
    
    self.itemSize = CGSizeMake(cellWidth, 70.0);
    self.sectionInset = UIEdgeInsetsMake(self.minimumInteritemSpacing, 0.0, 0.0, 0.0);
    self.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromSafeArea;
}

@end
