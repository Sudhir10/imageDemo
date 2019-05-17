//
//  NklResizeToolView.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklResizeToolView.h"

@implementation NklResizeToolView

- (void)awakeFromNib {
    [super awakeFromNib];
    selectedSize = 1.0;
    [self selectButton:originalButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)originalClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 1.0;
}
- (IBAction)seventyfiveClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.75;
}
- (IBAction)fiftyClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.5;
}
- (IBAction)twentyFiveClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.25;
}
- (IBAction)tenClick:(id)sender {
    [self selectButton:sender];
    selectedSize = 0.10;
}


- (IBAction)cancelClick:(id)sender {
    [self.listener nklResizeToolViewCancelClick:self];
}
- (IBAction)doneClick:(id)sender {
    [self.listener nklResizeToolView:self valueChange:selectedSize];
}

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
- (void) changeSelectionOfButton:(UIButton*)button
              withSelectedState : (BOOL)selected {
    [button setImage:selected ? [UIImage imageNamed:@"radio-selected"] : [UIImage imageNamed:@"radio-unselected"]  forState:UIControlStateNormal];
}
@end
