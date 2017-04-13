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
        
//        let viewsDictionary = ["sv":scrollView, "cv":containerView, "sldr":slider, "pb":photoAlbumBtn, "sb":savePhotoBtn] as [String : Any]
//
//        
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        slider.translatesAutoresizingMaskIntoConstraints = false
//        photoAlbumBtn.translatesAutoresizingMaskIntoConstraints = false
//        savePhotoBtn.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[sv]-20-[cv]-20-[sv]-[pb]-20-|",
//                                                                  options: [],
//                                                                  metrics: nil,
//                                                                  views: viewsDictionary))
//        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[sb]-40-[pb]-20-|",
//                                                                  options: [],
//                                                                  metrics: nil,
//                                                                  views: viewsDictionary))
        
        containerView.center = view.center
        originalImage.center = containerView.center
        imageToFilter.center = containerView.center
        scrollView.center.x = view.center.x
        
        
        
                var xCoord: CGFloat = 5
                let yCoord: CGFloat = 5
                let buttonWidth:CGFloat = 70
                let buttonHeight: CGFloat = 70
                let gapBetweenButtons: CGFloat = 5
        
        let myfilters = ["CIPhotoEffectChrome","CIPhotoEffectFade", "CIPhotoEffectInstant","CIPhotoEffectNoir","CIPhotoEffectProcess","CIPhotoEffectTonal","CIPhotoEffectTransfer","CISepiaTone"]
            
        
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
//            filter!.setValue(0.5, forKey: kCIInputIntensityKey)
//            print(filter!.value(forKey: kCIOutputImageKey))
            
            let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
            let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent)
//            let imageForButton = UIImage(cgImage: filteredImageRef!);
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

//    var context: CIContext!
//    var filter: CIFilter!
//    var coreImage: CIImage!
//    var coreOrientation: UIImageOrientation = .up
//    var coreScale: CGFloat!
//    
//    var myfilters = ["CIAccordionFoldTransition", "CIAdditionCompositing", "CIAffineClamp", "CIAffineTile", "CIAffineTransform", "CIAreaAverage", "CIAreaHistogram", "CIAreaMaximum", "CIAreaMaximumAlpha", "CIAreaMinimum", "CIAreaMinimumAlpha", "CIAztecCodeGenerator", "CIBarsSwipeTransition", "CIBlendWithAlphaMask", "CIBlendWithMask", "CIBloom", "CIBoxBlur", "CIBumpDistortion", "CIBumpDistortionLinear", "CICheckerboardGenerator", "CICircleSplashDistortion", "CICircularScreen", "CICircularWrap", "CIClamp", "CICMYKHalftone", "CICode128BarcodeGenerator", "CIColorBlendMode", "CIColorBurnBlendMode", "CIColorClamp", "CIColorControls", "CIColorCrossPolynomial", "CIColorCube", "CIColorCubeWithColorSpace", "CIColorDodgeBlendMode", "CIColorInvert", "CIColorMap", "CIColorMatrix", "CIColorMonochrome", "CIColorPolynomial", "CIColorPosterize", "CIColumnAverage", "CIComicEffect", "CIConstantColorGenerator", "CIConvolution3X3", "CIConvolution5X5", "CIConvolution7X7", "CIConvolution9Horizontal", "CIConvolution9Vertical", "CICopyMachineTransition", "CICrop", "CICrystallize", "CIDarkenBlendMode", "CIDepthOfField", "CIDifferenceBlendMode", "CIDiscBlur", "CIDisintegrateWithMaskTransition", "CIDisplacementDistortion", "CIDissolveTransition", "CIDivideBlendMode", "CIDotScreen", "CIDroste", "CIEdges", "CIEdgeWork", "CIEightfoldReflectedTile", "CIExclusionBlendMode", "CIExposureAdjust", "CIFalseColor", "CIFlashTransition", "CIFourfoldReflectedTile", "CIFourfoldRotatedTile", "CIFourfoldTranslatedTile", "CIGammaAdjust", "CIGaussianBlur", "CIGaussianGradient", "CIGlassDistortion", "CIGlassLozenge", "CIGlideReflectedTile", "CIGloom", "CIHardLightBlendMode", "CIHatchedScreen", "CIHeightFieldFromMask", "CIHexagonalPixellate", "CIHighlightShadowAdjust", "CIHistogramDisplayFilter", "CIHoleDistortion", "CIHueAdjust", "CIHueBlendMode", "CIHueSaturationValueGradient", "CIKaleidoscope", "CILanczosScaleTransform", "CILenticularHaloGenerator", "CILightenBlendMode", "CILightTunnel", "CILinearBurnBlendMode", "CILinearDodgeBlendMode", "CILinearGradient", "CILinearToSRGBToneCurve", "CILineOverlay", "CILineScreen", "CILuminosityBlendMode", "CIMaskedVariableBlur", "CIMaskToAlpha", "CIMaximumComponent", "CIMaximumCompositing", "CIMedianFilter", "CIMinimumComponent", "CIMinimumCompositing", "CIModTransition", "CIMotionBlur", "CIMultiplyBlendMode", "CIMultiplyCompositing", "CINinePartStretched", "CINinePartTiled", "CINoiseReduction", "CIOpTile", "CIOverlayBlendMode", "CIPageCurlTransition", "CIPageCurlWithShadowTransition", "CIParallelogramTile", "CIPDF417BarcodeGenerator", "CIPerspectiveCorrection", "CIPerspectiveTile", "CIPerspectiveTransform", "CIPerspectiveTransformWithExtent", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CIPinchDistortion", "CIPinLightBlendMode", "CIPixellate", "CIPointillize", "CIQRCodeGenerator", "CIRadialGradient", "CIRandomGenerator", "CIRippleTransition", "CIRowAverage", "CISaturationBlendMode", "CIScreenBlendMode", "CISepiaTone", "CIShadedMaterial", "CISharpenLuminance", "CISixfoldReflectedTile", "CISixfoldRotatedTile", "CISmoothLinearGradient", "CISoftLightBlendMode", "CISourceAtopCompositing", "CISourceInCompositing", "CISourceOutCompositing", "CISourceOverCompositing", "CISpotColor", "CISpotLight", "CISRGBToneCurveToLinear", "CIStarShineGenerator", "CIStraightenFilter", "CIStretchCrop", "CIStripesGenerator", "CISubtractBlendMode", "CISunbeamsGenerator", "CISwipeTransition", "CITemperatureAndTint", "CIThermal", "CIToneCurve", "CITorusLensDistortion", "CITriangleKaleidoscope", "CITriangleTile", "CITwelvefoldReflectedTile", "CITwirlDistortion", "CIUnsharpMask", "CIVibrance", "CIVignette", "CIVignetteEffect", "CIVortexDistortion", "CIWhitePointAdjust", "CIXRay", "CIZoomBlur"]
//    
//    
//   
//    
//   
//    override func viewDidLoad() {
//        
//        var xCoord: CGFloat = 5
//        let yCoord: CGFloat = 5
//        let buttonWidth:CGFloat = 70
//        let buttonHeight: CGFloat = 70
//        let gapBetweenButtons: CGFloat = 5
//        
//        
//        
//        scrollView.frame.size.width = view.frame.size.width
//
//        imageView.center = view.center
//        
//        guard let image = imageView?.image, let cgimg = image.cgImage else {
//            
//            
//            print("imageView doesn't have an image!")
//            return
//        }
//    
//      
//       coreScale = image.scale
//        
//        let openGLContext = EAGLContext(api: .openGLES2)
//        context = CIContext(eaglContext: openGLContext!)
//        
//        coreImage = CIImage(cgImage: cgimg)
//        
//        filter = CIFilter(name: "CISepiaTone")
//        filter?.setValue(coreImage, forKey: kCIInputImageKey)
//        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
//        
//        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
//
//            let cgimgresult = context.createCGImage(output, from: output.extent)
//            let result = UIImage(cgImage: cgimgresult!, scale: image.scale, orientation: coreOrientation)
//            imageView?.image = result
//        
//
//        }
//        
//        else {
//            print("image filtering failed")
//        }
//        
//        var itemCount = 0
//        
//        for each in myfilters {
//            
//            itemCount += 1
//            
//            let filterButton = UIButton(type: .custom)
//            filterButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
//            
//            filterButton.tag = itemCount
//            //            filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
//            
//            filterButton.layer.cornerRadius = 6
//            filterButton.clipsToBounds = true
//
//            let filt = CIFilter(name: each)
//            
//
////
////            if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
////                
////                let cgimgresult = context.createCGImage(output, from: output.extent)
////                let imageForButton = UIImage(cgImage: cgimgresult!)
////                
////                filterButton.setBackgroundImage(imageForButton, for: .normal)
////                
////            }
////            
////            // Add Buttons in the Scroll View
////            xCoord +=  buttonWidth + gapBetweenButtons
////            scrollView.addSubview(filterButton)
//        }
//        
////        scrollView.contentSize = CGSize(width: (buttonWidth * CGFloat(itemCount+2)), height: yCoord)
//        
//    }
//    
//    
//
//    
//    @IBAction func sliderValueChanged(_ sender: UISlider) {
//        
//        let sliderValue = sender.value
//        
//        filter.setValue(sliderValue, forKey: kCIInputIntensityKey)
//        let outputImage = filter.outputImage
//        
//        let cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
//        
//        let newImage = UIImage(cgImage: cgimg!, scale: coreScale, orientation: coreOrientation)
//        self.imageView.image = newImage
//        
//    }
//    
//    @IBAction func loadPhoto(_ sender: Any) {
//        
//        let pickerC = UIImagePickerController()
//        pickerC.delegate = self
//        self.present(pickerC, animated: true, completion: nil)
//        
//        
//    }
//    
//      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        self.dismiss(animated: true, completion: nil);
//        
//        let gotImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        coreOrientation = gotImage.imageOrientation
//        
//        coreImage = CIImage(image:gotImage)
//        
//        filter.setValue(coreImage, forKey: kCIInputImageKey)
//        self.sliderValueChanged(slider)
//
//        
//        
//    }
//    
//    @IBAction func savePhoto(_ sender: Any) {
//        
//        // 1
//        let imageToSave = filter.outputImage
//        
//        // 2
//        let softwareContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])
//        
//        // 3
//        let cgimg = softwareContext.createCGImage(imageToSave!, from:imageToSave!.extent)
//        
//        // 4
//        let library = ALAssetsLibrary()
//        library.writeImage(toSavedPhotosAlbum: cgimg,
//                                             metadata:imageToSave!.properties,
//                                             completionBlock:nil)
//        
//    }
//}
//





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

