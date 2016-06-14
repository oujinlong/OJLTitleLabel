//
//  ViewController.m
//  OJLLabelLayout
//
//  Created by oujinlong on 16/6/12.
//  Copyright © 2016年 oujinlong. All rights reserved.
//

#import "ViewController.h"
#import "OJLLabelLayout.h"
#import "OJLCollectionViewCell.h"
@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,OJLLabelLayoutDelegate>
@property (nonatomic, strong) NSMutableArray* titles;
@property (nonatomic, weak) UICollectionView* collectionView;
@property (nonatomic, weak) UITextField* textField;
@end

@implementation ViewController
static NSString* identifier = @"cell";
- (NSArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:@[@"这是第1条标签",@"这是第2条标签用来测试很长的长度的",@"这个第3条比较短",@"测试的第4个",@"测试的第5个af",@"第6个",@"7",@"8随便插"]];
        
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    OJLLabelLayout* layout = [[OJLLabelLayout alloc] init];
    layout.panding = 10;
    layout.rowPanding = 20;
    layout.delegate = self;
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerNib:[UINib nibWithNibName:@"OJLCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:collectionView];
    
    
    UITextField* textField = [[UITextField alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(collectionView.frame)+ 50, 200, 25)];
    self.textField = textField;
    textField.placeholder = @"再此输入要插入的标签";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(110, CGRectGetMaxY(textField.frame) + 10, 60, 30);
    [button setTitle:@"插入" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

-(void)add{
    if (self.textField.text.length) {
        [self.titles addObject:self.textField.text];
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.titles.count - 1 inSection:0]]];
    }
}

#pragma mark OJLLabelLayoutDelegate
-(NSArray *)OJLLabelLayoutTitlesForLabel{
    return self.titles;
}
#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OJLCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell setTitle:self.titles[indexPath.item]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.titles[indexPath.item]);
}
@end
