//
//  ViewController.swift
//  colorWheel
//
//  Created by Emmet Susslin on 4/11/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import CoreImage
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
   
    override func viewDidLoad() {
        
        imageView.center = view.center
        
        guard let image = imageView?.image, let cgimg = image.cgImage, let orientation = imageView.image?.imageOrientation else {
            
            
            print("imageView doesn't have an image!")
            return
        }
        
        let openGLContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: openGLContext!)
        
        let coreImage = CIImage(cgImage: cgimg)
        
//        let filter = CIFilter(name: "CISepiaTone")
//        filter?.setValue(coreImage, forKey: kCIInputImageKey)
//        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        
        let sepiaFilter = CIFilter(name: "CISepiaTone")
        sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(1, forKey: kCIInputIntensityKey)
        
        if let sepiaOutput = sepiaFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
            let exposureFilter = CIFilter(name: "CIExposureAdjust")
            exposureFilter?.setValue(sepiaOutput, forKey: kCIInputImageKey)
            exposureFilter?.setValue(1, forKey: kCIInputEVKey)
            
            if let exposureOutput = exposureFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
                let output = context.createCGImage(exposureOutput, from: exposureOutput.extent)
                let result = UIImage(cgImage: output!, scale: image.scale, orientation: orientation)
                imageView?.image = result
            }
        }
        
//        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
//
//            let cgimgresult = context.createCGImage(output, from: output.extent)
//            let result = UIImage(cgImage: cgimgresult!, scale: image.scale, orientation: orientation)
//            imageView?.image = result
//        
////            
////            
////            let filteredImage = UIImage(ciImage: output, scale: image.scale, orientation: orientation)
////
//////            imageView?.image = filteredImage
//        }
        
        else {
            print("image filtering failed")
        }
    }
}
