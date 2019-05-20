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

// filter tool view
@implementation NklFilterToolView

- (void)awakeFromNib {
    [super awakeFromNib];
    UINib *nib = [UINib nibWithNibName:@"NklFilterCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"cell"];
    
    //get all supported filters
    _imageFilters = [NklFilter getFilterNames];
    
}

// Get the cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
    cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NklFilterCell *cell = (NklFilterCell *)[collectionView
                                          dequeueReusableCellWithReuseIdentifier:@"cell"
                                          forIndexPath:indexPath];
    cell.nameLabel.text = _imageFilters[indexPath.row];
    cell.filterPreviewImageView.image = [NklFilter filterImageOnImage:self.originalImage byType:[NklFilter getFilterTypeFromString:_imageFilters[indexPath.row]]];
    return cell;
}

// Get the number of collections
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _imageFilters.count;
}

//Get size of cell
- (CGSize)collectionView:(UICollectionView *)collectionView
    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetHeight(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
}

//Get selected cell
- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.listener onFilterSelected:[NklFilter getFilterTypeFromString:_imageFilters[indexPath.row]]];\
}
@end
