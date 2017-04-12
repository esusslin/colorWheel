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
        guard let image = imageView?.image, let cgimg = image.cgImage, let orientation = imageView.image?.imageOrientation else {
            
            
            print("imageView doesn't have an image!")
            return
        }
        
        let coreImage = CIImage(cgImage: cgimg)
        
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(coreImage, forKey: kCIInputImageKey)
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {

            let filteredImage = UIImage(ciImage: output, scale: image.scale, orientation: orientation)
                imageView?.image = filteredImage
        }
            
        else {
            print("image filtering failed")
        }
    }
}


//let newImage = UIImage(CIImage:filter.outputImage, scale:self.image.scale, orientation:self.image.imageOrientation)
