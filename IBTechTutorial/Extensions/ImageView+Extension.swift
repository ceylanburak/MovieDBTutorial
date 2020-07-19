//
//  ImageView+Extension.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(with urlString: String, size: CGSize) {
        if let imageFromCache = Constants.imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
        }else {
            downloadImage(with: urlString, size: size)
        }
    }
    
    fileprivate func downloadImage(with urlString: String, size: CGSize)  {
        NetworkManager.downloadImage(with: urlString) { (data) in
            if let data = data, let image = UIImage(data: data) {
                Constants.imageCache.setObject(image, forKey: urlString as NSString)

                DispatchQueue.main.async {
                    guard let imageFromCache = Constants.imageCache.object(forKey: urlString as NSString) else {return}
                    self.image = imageFromCache
                }
            }
        }
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
      let size = self.size
      let widthRatio  = targetSize.width  / size.width
      let heightRatio = targetSize.height / size.height
      let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
      let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

      UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
      self.draw(in: rect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      return newImage!
    }
    
}
