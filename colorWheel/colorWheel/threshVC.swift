//
//  threshVC.swift
//  colorWheel
//
//  Created by Emmet Susslin on 4/28/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit
import CoreImage


class threshVC: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    var newImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomFiltersVendor.registerFilters()
        
        guard let filterName = CIFilter.filterNames(inCategory: CategoryCustomFilters).first else
        {
            return
        }
        
        let threshold = 0.5
        let newPic = CIImage(image: newImage)!
        
        let filter = CIFilter(
            name: filterName,
            withInputParameters: [kCIInputImageKey: newPic, "inputThreshold": threshold])
        
        guard let outputImage = filter?.outputImage else
        {
            return
        }
        
        let context = CIContext()
        
        let final: CGImage = context.createCGImage(outputImage, from: outputImage.extent)!
        
        let frame = CGRect(
            x: Int(view.bounds.midX) - final.width / 2,
            y: Int(view.bounds.midY) - final.height / 2,
            width: final.width,
            height: final.height)
        
        
        image.image = UIImage(cgImage: final)
        
        image.center = view.center

        
    }

    
}

// MARK: Filters
let CategoryCustomFilters = "Custom Filters"

class CustomFiltersVendor: NSObject, CIFilterConstructor
{
    @available(iOS 5.0, *)
    
    
    public func filter(withName name: String) -> CIFilter? {
        switch name
        {
        case "ThresholdFilter":
            return ThresholdFilter()
            
        default:
            return nil
        }

    }

    static func registerFilters()
    {
        CIFilter.registerName(
            "ThresholdFilter",
            constructor: CustomFiltersVendor(),
            classAttributes: [
                kCIAttributeFilterCategories: [CategoryCustomFilters]
            ])
    }
    
}

class ThresholdFilter: CIFilter
{
    var inputImage : CIImage?
    var inputThreshold: CGFloat = 0.75
    
    override var attributes: [String : Any]
    {
        return [
            kCIAttributeFilterDisplayName: "Threshold Filter",
            "inputImage": [kCIAttributeIdentity: 0,
                           kCIAttributeClass: "CIImage",
                           kCIAttributeDisplayName: "Image",
                           kCIAttributeType: kCIAttributeTypeImage],
            "inputThreshold": [kCIAttributeIdentity: 0,
                               kCIAttributeClass: "NSNumber",
                               kCIAttributeDefault: 0.75,
                               kCIAttributeDisplayName: "Threshold",
                               kCIAttributeMin: 0,
                               kCIAttributeSliderMin: 0,
                               kCIAttributeSliderMax: 1,
                               kCIAttributeType: kCIAttributeTypeScalar]
        ]
    }
    
    override func setDefaults()
    {
        inputThreshold = 0.75
    }
    
    override init()
    {
        super.init()
        
        thresholdKernel = CIColorKernel(string:
            "kernel vec4 thresholdFilter(__sample image, float threshold)" +
                "{" +
                "   float luma = dot(image.rgb, vec3(0.2126, 0.7152, 0.0722));" +
                
                "   return vec4(vec3(step(threshold, luma)), 1.0);" +
            "}"
        )
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    var thresholdKernel: CIColorKernel?
    
    override var outputImage: CIImage!
    {
        guard let inputImage = inputImage,
            let thresholdKernel = thresholdKernel else
        {
            return nil
        }
        
        let extent = inputImage.extent
        let arguments = [inputImage, inputThreshold] as [Any]
        
        return thresholdKernel.apply(withExtent: extent, arguments: arguments)
    }
}


//class ThresholdFilter: CIFilter
//{
//    var inputImage : CIImage?
////    var inputThreshold: CGFloat = 0.75
//    
//    var inputThreshold: NSNumber = 0.75
//    
//    override var attributes: [String : Any]
//    {
//        return [
//            kCIAttributeFilterDisplayName: "Threshold Filter" as AnyObject,
//            "inputImage": [kCIAttributeIdentity: 0,
//                           kCIAttributeClass: "CIImage",
//                           kCIAttributeDisplayName: "Image",
//                           kCIAttributeType: kCIAttributeTypeImage],
//            "inputThreshold": [kCIAttributeIdentity: 0,
//                               kCIAttributeClass: "NSNumber",
//                               kCIAttributeDefault: 0.75,
//                               kCIAttributeDisplayName: "Threshold",
//                               kCIAttributeMin: 0,
//                               kCIAttributeSliderMin: 0,
//                               kCIAttributeSliderMax: 1,
//                               kCIAttributeType: kCIAttributeTypeScalar]
//        ]
//    }
//    
//    override var outputImage: CIImage!
//    {
//        guard let inputImage = inputImage,
//            let thresholdKernel = thresholdKernel else
//        {
//            return nil
//        }
//        
//        let extent = inputImage.extent
//        let arguments = [inputImage, inputThreshold] as [Any]
//        
//        return thresholdKernel.apply(withExtent: extent, arguments: arguments)
//    }
//    
//    
//}
//
//extension String
//{
//    var nsString: NSString
//    {
//        return NSString(string: self)
//    }
//}
