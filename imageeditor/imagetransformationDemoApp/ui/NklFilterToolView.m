//
//  NklFilterToolView.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklFilterToolView.h"
#import "NklFilterCell.h"

#import <imagetransformation/imagetransformation-Swift.h>


@implementation NklFilterToolView

- (void)awakeFromNib {
    [super awakeFromNib];
    UINib *nib = [UINib nibWithNibName:@"NklFilterCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    _imageFilters = [NklFilter getFilterNames];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
    cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NklFilterCell *cell = (NklFilterCell *)[collectionView
                                          dequeueReusableCellWithReuseIdentifier:@"cell"
                                          forIndexPath:indexPath];
    cell.nameLabel.text = _imageFilters[indexPath.row];
    cell.filterPreviewImageView.image = [NklFilter filterImageOnImage:self.originalImage byType:[NklFilter getFilterTypeFromString:_imageFilters[indexPath.row]]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _imageFilters.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetHeight(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.listener onFilterSelected:[NklFilter getFilterTypeFromString:_imageFilters[indexPath.row]]];\
}
@end
