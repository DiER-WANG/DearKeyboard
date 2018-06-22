//
//  FancyLayout.m
//  DearKeyboard
//
//  Created by 王昌阳 on 2018/6/10.
//  Copyright © 2018年 王昌阳. All rights reserved.
//

#import "FancyLayout.h"

@interface FancyLayout()
{
    CGRect contentBounds;
    NSMutableArray  *cachedAttributes;
}

@end

@implementation FancyLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    UICollectionView *cv = self.collectionView;
    
    // Reset cahced info
    [cachedAttributes removeAllObjects];
    contentBounds = CGRectMake(0, 0, cv.bounds.size.width, cv.bounds.size.height);
    
    [self createAttributes];
}

- (CGSize)collectionViewContentSize {
    return contentBounds.size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UICollectionView *vc = self.collectionView;
    return (newBounds.size.width == vc.bounds.size.width && newBounds.size.height == vc.bounds.size.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return cachedAttributes[indexPath.item];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attr = [[NSMutableArray alloc] init];
    for (UICollectionViewLayoutAttributes *attributes in cachedAttributes) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [attr addObject:attributes];
        }
    }
    return attr;
}


/**
 For every item
 - Prepare attributes
 - Store attributes in cachedAttributes array
 - union contentBounds with attributes.frame
 */
- (void)createAttributes {
    
}


@end
