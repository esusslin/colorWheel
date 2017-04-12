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
    
    @IBOutlet weak var slider: UISlider!
    
    
    var context: CIContext!
    var filter: CIFilter!
    var coreImage: CIImage!
    var coreOrientation: UIImageOrientation!
    var coreScale: CGFloat!
    
   
    override func viewDidLoad() {
        
        imageView.center = view.center
        
        guard let image = imageView?.image, let cgimg = image.cgImage, let orientation = imageView.image?.imageOrientation else {
            
            
            print("imageView doesn't have an image!")
            return
        }
    
       coreOrientation = orientation
       coreScale = image.scale
        
        let openGLContext = EAGLContext(api: .openGLES2)
        context = CIContext(eaglContext: openGLContext!)
        
        coreImage = CIImage(cgImage: cgimg)
        
        filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(coreImage, forKey: kCIInputImageKey)
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {

            let cgimgresult = context.createCGImage(output, from: output.extent)
            let result = UIImage(cgImage: cgimgresult!, scale: image.scale, orientation: orientation)
            imageView?.image = result
        

        }
        
        else {
            print("image filtering failed")
        }
    }
    
    

    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let sliderValue = sender.value
        
        filter.setValue(sliderValue, forKey: kCIInputIntensityKey)
        let outputImage = filter.outputImage
        
        let cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
        
        print("ORIENTATION")
        print(coreOrientation)
        print("SCALE")
        print(coreScale)
        print("CGIMG")
        print(cgimg!)
        
        let newImage = UIImage(cgImage: cgimg!, scale: coreScale, orientation: coreOrientation)
        self.imageView.image = newImage
        
    }
    
    
    
    
    
}





//        let sepiaFilter = CIFilter(name: "CISepiaTone")
//        sepiaFilter?.setValue(coreImage, forKey: kCIInputImageKey)
//        sepiaFilter?.setValue(1, forKey: kCIInputIntensityKey)
//
//        if let sepiaOutput = sepiaFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
//            let exposureFilter = CIFilter(name: "CIExposureAdjust")
//            exposureFilter?.setValue(sepiaOutput, forKey: kCIInputImageKey)
//            exposureFilter?.setValue(1, forKey: kCIInputEVKey)
//
//            if let exposureOutput = exposureFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
//                let output = context.createCGImage(exposureOutput, from: exposureOutput.extent)
//                let result = UIImage(cgImage: output!, scale: image.scale, orientation: orientation)
//                imageView?.image = result
//            }
//        }
//

