//
//  UIImageView_+_maskCircle.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //method for changing rectangular UIImage into circular one
    public func maskCircle(anyImage: UIImage, andSize size: CGFloat) {
        let resized = resizeImage(image: anyImage, targetSize: CGSize(width: size, height: size))
        self.contentMode        = .scaleAspectFill
        guard let resizedImage  = resized else {return}
        self.layer.cornerRadius = resizedImage.size.height/2 //.height / 2
//        self.layer.masksToBounds = false
        self.clipsToBounds      = true
            self.image = resizedImage
        }
    
    fileprivate func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
