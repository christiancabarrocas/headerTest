//
//  ImageExtension.swift
//  headerTest
//
//  Created by Christian Cabarrocas on 23/09/15.
//  Copyright (c) 2015 ccs. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func blackAndWhite () {
        let filter = CIFilter(name:"CIPhotoEffectNoir")
        let context = CIContext(options: nil)
        let ciImage = CIImage(image:self.image)
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        let imageSize:CGRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width*2, self.frame.height*2)
        self.image = UIImage(CGImage: context.createCGImage(filter.outputImage, fromRect: imageSize))
    }
}