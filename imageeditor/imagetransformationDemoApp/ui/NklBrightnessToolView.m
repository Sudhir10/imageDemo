//
//  NklBrightnessToolView.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklBrightnessToolView.h"

@interface NklBrightnessToolView()
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

@end

@implementation NklBrightnessToolView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)onSliderValueChange:(id)sender {
    [self.listener nklBrightnessToolView:self valueChange:self.brightnessSlider.value];
}

@end
