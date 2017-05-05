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
        
        image.image = self.newImage
        
        image.center = view.center

        // Do any additional setup after loading the view.
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
