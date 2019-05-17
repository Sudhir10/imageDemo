//
//  FilterCollectionViewCell.h
//  imagetransformationDemoApp
//
//  Created by Sudhir on 16/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NklFilterCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *filterPreviewImageView;
@end

NS_ASSUME_NONNULL_END
