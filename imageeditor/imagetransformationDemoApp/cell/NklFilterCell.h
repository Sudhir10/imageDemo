//
//  FilterCollectionViewCell.h
//  imagetransformationDemoApp
//
//  Created by Sudhir on 16/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

// filter cell
@interface NklFilterCell : UICollectionViewCell

//UI
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *filterPreviewImageView;
@end
