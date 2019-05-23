//
//  NklResizeToolView.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklResizeToolView.h"

// resize tool view
@implementation NklResizeToolView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // set default size
    selectedSize = 1.0;
    [self selectButton:originalButton];
}
//====================
//event
//====================
// called when original button clicked
- (IBAction)originalClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 1.0;
    [self.listener nklResizeToolView:self valueChange:selectedSize];
}

// called when 75 % button clicked
- (IBAction)seventyfiveClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.75;
    [self.listener nklResizeToolView:self valueChange:selectedSize];
}

// called when 50 % button clicked
- (IBAction)fiftyClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.5;
    [self.listener nklResizeToolView:self valueChange:selectedSize];
}

// called when 25 % button clicked
- (IBAction)twentyFiveClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.25;
    [self.listener nklResizeToolView:self valueChange:selectedSize];
}

// called when 10 % button clicked
- (IBAction)tenClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.10;
    [self.listener nklResizeToolView:self valueChange:selectedSize];
}

// called when cancel button clicked
- (IBAction)cancelClick:(id)sender {
    [self.listener nklResizeToolViewCancelClick:self];
}

// called when done button clicked
- (IBAction)doneClick:(id)sender {
    [self.listener nklResizeToolView:self doneClickWithValueChange:selectedSize];
}

// select given button and clear all selection
- (void) selectButton:(UIButton*)button {
    // un select all button
    [self changeSelectionOfButton:originalButton withSelectedState:NO];
    [self changeSelectionOfButton:seventyfiveButton withSelectedState:NO];
    [self changeSelectionOfButton:fiftyButton withSelectedState:NO];
    [self changeSelectionOfButton:twentyFiveButton withSelectedState:NO];
    [self changeSelectionOfButton:tenButton withSelectedState:NO];
    
    // select specified button
    [self changeSelectionOfButton:button withSelectedState:YES];
    
}

// change image of radio based on selected value
- (void) changeSelectionOfButton:(UIButton*)button
              withSelectedState : (BOOL)selected {
    [button setImage:selected ? [UIImage imageNamed:@"radio-selected"] : [UIImage imageNamed:@"radio-unselected"]  forState:UIControlStateNormal];
}
@end
