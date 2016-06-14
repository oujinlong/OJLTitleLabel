//
//  OJLLabelLayout.h
//  OJLLabelLayout
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OJLLabelLayoutDelegate <NSObject>
/**
 *  数据源代理
 *
 *  @return 标签的标题数组
 */
-(NSArray*)OJLLabelLayoutTitlesForLabel;

@end

@interface OJLLabelLayout : UICollectionViewLayout
@property (nonatomic, weak) id <OJLLabelLayoutDelegate> delegate;
/**
 *  同一行之间标签的间距
 */
@property (nonatomic, assign) CGFloat panding;
/**
 *  同一列之间标签的间距
 */
@property (nonatomic, assign) CGFloat rowPanding;
@end
