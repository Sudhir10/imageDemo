//
//  NklResizeToolView.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NklResizeToolViewListener.h"

// resize tool view
@interface NklResizeToolView : UIView {
    
    __weak IBOutlet UIButton *originalButton;
    __weak IBOutlet UIButton *seventyfiveButton;
    __weak IBOutlet UIButton *fiftyButton;
    __weak IBOutlet UIButton *twentyFiveButton;
    __weak IBOutlet UIButton *tenButton;
    CGFloat selectedSize;
}

//UI
@property (weak, nonatomic) id<NklResizeToolViewListener> listener;

@end
