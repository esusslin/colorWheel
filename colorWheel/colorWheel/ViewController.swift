//
//  ViewController.swift
//  colorWheel
//
//  Created by Emmet Susslin on 4/11/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import CoreImage
import UIKit
import AssetsLibrary

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var originalImage: UIImageView!
    
    @IBOutlet weak var imageToFilter: UIImageView!
    @IBOutlet weak var slider: UISlider!

    

    @IBOutlet weak var photoAlbumBtn: UIButton!
    @IBOutlet weak var savePhotoBtn: UIButton!


    override func viewDidLoad() {

        
        containerView.center = view.center
        originalImage.center = containerView.center
        imageToFilter.center = containerView.center
        scrollView.center.x = view.center.x
        
        
        
                var xCoord: CGFloat = 5
                let yCoord: CGFloat = 5
                let buttonWidth:CGFloat = 70
                let buttonHeight: CGFloat = 70
                let gapBetweenButtons: CGFloat = 5
        
        let myfilters = ["CIColorPosterize","CIColorMonochrome","CIPhotoEffectChrome","CIPhotoEffectFade", "CIPhotoEffectInstant","CIPhotoEffectNoir","CIPhotoEffectProcess","CIPhotoEffectTonal","CIPhotoEffectTransfer","CISepiaTone"]
            
        
        var itemCount = 0
        
        for each in myfilters {
            
            
            
            // Button properties
            let filterButton = UIButton(type: .custom)
            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            filterButton.tag = itemCount
            filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
            filterButton.layer.cornerRadius = 6
            filterButton.clipsToBounds = true
        
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: originalImage.image!)
            let filter = CIFilter(name: each)
            filter!.setDefaults()
            filter!.setValue(coreImage, forKey: kCIInputImageKey)

            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)

            let imageForButton = UIImage(cgImage: filteredImageRef!, scale: 1.0, orientation: .down)
            
            // Assign filtered image to the button
            filterButton.setBackgroundImage(imageForButton, for: .normal)
        
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            scrollView.addSubview(filterButton)
        }
        // Resize Scroll View
        scrollView.contentSize = CGSize(width: (buttonWidth * CGFloat(myfilters.count+2)), height: yCoord)

    }
    
    func filterButtonTapped(sender: UIButton) {
        let button = sender as UIButton
        print("BONER!")
        imageToFilter.image = button.backgroundImage(for: UIControlState.normal)
    }

}


