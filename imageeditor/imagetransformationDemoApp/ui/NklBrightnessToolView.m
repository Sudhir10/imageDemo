//
//  NklBrightnessToolView.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklBrightnessToolView.h"

//brightness tool view
@interface NklBrightnessToolView()

//slider
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

@end

@implementation NklBrightnessToolView

//called when slider value change
- (IBAction)onSliderValueChange:(id)sender {
    [self.listener nklBrightnessToolView:self valueChange:self.brightnessSlider.value];
}

@end
