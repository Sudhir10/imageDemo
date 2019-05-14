//
//  GPUImageAdapter.swift
//  imageeditor
//
//  Created by Sudhir on 13/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

import UIKit
import GPUImage

@objc class GPUImageAdapter : NSObject {
    @objc class func adjustBrightness(ofImage : UIImage , withValue : Float) -> UIImage {
        let brightnessfilter = BrightnessAdjustment()
        brightnessfilter.brightness = withValue
        return ofImage.filterWithOperation(brightnessfilter)
    }
}
