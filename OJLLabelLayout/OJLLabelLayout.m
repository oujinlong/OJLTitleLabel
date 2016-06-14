//
//  OJLLabelLayout.m
//  OJLLabelLayout
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import "OJLLabelLayout.h"

@interface OJLLabelLayout ()
@property (nonatomic, strong) NSMutableArray* attrArray;
@property (nonatomic, strong) NSMutableArray* maxXArray;
@property (nonatomic, assign) CGFloat numberOfRow;
@end
@implementation OJLLabelLayout
- (NSMutableArray *)attrArray
{
    if (!_attrArray) {
        _attrArray = [NSMutableArray new];
    }
    return _attrArray;
}
- (NSMutableArray *)maxXArray
{
    if (!_maxXArray) {
        _maxXArray = [NSMutableArray new];
        
    }
    return _maxXArray;
}

-(void)prepareLayout{

    self.maxXArray = nil;
    self.attrArray = nil;
    [self.maxXArray addObject:@0];
    self.numberOfRow = 1 ;

    [self.attrArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0 ; i < count; i++) {
        UICollectionViewLayoutAttributes* attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrArray addObject:attr];
    }
    
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return self.attrArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat panding = self.panding ? self.panding : 5;
    CGFloat rowPanding = self.rowPanding ? self.rowPanding : 5;
    
    NSArray* titles = [self.delegate OJLLabelLayoutTitlesForLabel];
    
    NSString* title = titles[indexPath.item];
    
    CGRect rect = [title boundingRectWithSize:CGSizeMake(500, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:19]} context:nil];
    
    
    CGSize titleSize =  rect.size;
    CGFloat width = titleSize.width + 8;
    CGFloat height = titleSize.height;
    
    NSInteger currentRow = 0;
    for (NSInteger i = 0 ; i < self.numberOfRow; i ++ ) {
        
        if (titleSize.width + [self.maxXArray[i] floatValue] + panding <= self.collectionView.bounds.size.width - panding) {
            currentRow = i ;
            break;
        }
        if (i == self.numberOfRow - 1) {
            self.numberOfRow ++ ;
            [self.maxXArray addObject:@0];
            currentRow = self.numberOfRow - 1;
            break;
        }
    }
    

    
    CGFloat X = [self.maxXArray[currentRow] floatValue] + panding;
    CGFloat Y = rowPanding + (height + panding) * currentRow;
  
    self.maxXArray[currentRow] = @(X + width);
    
    attr.frame = CGRectMake(X, Y, width, height);
    
    
    return attr;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(0, 500);
}
@end
