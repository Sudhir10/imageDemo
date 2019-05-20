//
//  GPUImageAdapter.swift
//  imageeditor
//
//  Created by Sudhir on 13/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

import UIKit
import GPUImage

// filter type
@objc public  enum NklFilterType: Int {
    // list of supported filter types
    case Default = 0
    case Hue
    case Gamma
    case Sepia
    case Emboss
    case MonoChrome
    case RGB
    case Vignette
    case ToneCurve
    case Luminance
    case Haze
    
    //convert self to string representation
    func toString() -> String {
        switch self {
        case .Default:
            return "Default"
        case .Hue:
            return "Hue"
        case .Gamma:
            return "Gamma"
        case .Sepia:
            return "Sepia"
        case .Emboss:
            return "Emboss"
        case .RGB:
            return "RGB"
        case .Vignette:
            return "Vignette"
        case .ToneCurve:
            return "ToneCurve"
        case .Luminance:
            return "Luminance"
        case .Haze:
            return "Haze"
        case .MonoChrome:
            return "MonoChrome"
        }
    }
    
    // convert string to filter type
    static func toFilterType(fromString : String) throws -> NklFilterType  {
        if NklFilterType.Default.toString() == fromString {
            return .Default
        }
        else if NklFilterType.Hue.toString() == fromString {
            return .Hue
        }
        else if NklFilterType.Gamma.toString() == fromString {
            return .Gamma
        }
        else if NklFilterType.Sepia.toString() == fromString {
            return .Sepia
        }
        else if NklFilterType.Emboss.toString() == fromString {
            return .Emboss
        }
        else if NklFilterType.RGB.toString() == fromString {
            return .RGB
        }
        else if NklFilterType.Vignette.toString() == fromString {
            return .Vignette
        }
        else if NklFilterType.ToneCurve.toString() == fromString {
            return .ToneCurve
        }
        else if NklFilterType.Luminance.toString() == fromString {
            return .Luminance
        }
        else if NklFilterType.Haze.toString() == fromString {
            return .Haze
        }
        else if NklFilterType.MonoChrome.toString() == fromString {
            return .MonoChrome
        }
        throw NSError(domain: "NklFilter", code: 404, userInfo: ["String" : "Any"])
    }
}

// filter
@objc public class NklFilter : NSObject {
    
    // convert string to filter if convertible else return default
    @objc public class func getFilterType(fromString : String) -> NklFilterType {
        do {
            return try NklFilterType.toFilterType(fromString: fromString)
        }
        catch {}
        // return default when given string is not converted
        return .Default
    }

    // return supported filter count
    @objc public class func getFilterCount() -> Int {
        return NklFilter.getFilterNames().count
    }
    
    // get supported filters name
    @objc public class func getFilterNames() -> NSArray {
        return [NklFilterType.Default.toString(),
                NklFilterType.Hue.toString(),
                NklFilterType.Gamma.toString(),
                NklFilterType.Sepia.toString(),
                NklFilterType.Emboss.toString(),
                NklFilterType.RGB.toString(),
                NklFilterType.Vignette.toString(),
                NklFilterType.ToneCurve.toString(),
                NklFilterType.Luminance.toString(),
                NklFilterType.Haze.toString(),
                NklFilterType.MonoChrome.toString()]
    }
    
    //get image after chaining brightness
    @objc public class func adjustBrightness(ofImage : UIImage , withValue : Float) -> UIImage {
        let brightnessfilter = BrightnessAdjustment()
        brightnessfilter.brightness = withValue
        return ofImage.filterWithOperation(brightnessfilter)
    }
    
    //apply filter type on given image
    @objc public class func filterImage(onImage : UIImage , byType : NklFilterType) -> UIImage {
        switch byType {
        case .Default:
            return onImage
        case .Hue:
            return applyHueFilter(onImage: onImage)
        case .Gamma:
            return applyGammaFilter(onImage: onImage)
        case .Sepia:
            return applySepiaFilter(onImage: onImage)
        case .Emboss:
            return applyEmbossFilter(onImage: onImage)
        case .RGB:
            return applyRGBFilter(onImage: onImage)
        case .Vignette:
            return applyVignetteFilter(onImage: onImage)
        case .ToneCurve:
            return applyToneCurveFilter(onImage: onImage)
        case .Luminance:
            return applyLuminanceFilter(onImage: onImage)
        case .Haze:
            return applyHazeFilter(onImage: onImage)
        case .MonoChrome:
            return applyMonoChromFilter(onImage: onImage)
        }
    }
}

//MARK: private
extension NklFilter {
    // hue filter
    class func applyHueFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = HueAdjustment()
        return onImage.filterWithOperation(brightnessfilter)
    }

    // 
    class func applyGammaFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = GammaAdjustment()
        return onImage.filterWithOperation(brightnessfilter)
    }
    
    class func applySepiaFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = SepiaToneFilter()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyGrayScaleFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = MonochromeFilter()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyEmbossFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = EmbossFilter()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applySaturationFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = SaturationAdjustment()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyMonoChromFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = MonochromeFilter()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyRGBFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = RGBAdjustment()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyVignetteFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = Vignette()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyToneCurveFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = ToonFilter()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyLuminanceFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = Luminance()
        return onImage.filterWithOperation(brightnessfilter)
    }
    class func applyHazeFilter(onImage : UIImage) -> UIImage{
        let brightnessfilter = Haze()
        return onImage.filterWithOperation(brightnessfilter)
    }

}
