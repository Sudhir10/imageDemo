//
//  NklFilterToolView.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NklFilterToolViewListener.h"

// filter tool view
@interface NklFilterToolView : UIView <
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout> {
        
        NSArray *_imageFilters;
}


//UI
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id <NklFilterToolViewListener> listener;
@property (strong, nonatomic) UIImage *originalImage;

@end
