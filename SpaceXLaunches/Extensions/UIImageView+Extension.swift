//
//  UIImageView+Extension.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/5/24.
//

import UIKit

// create an image cache to cache the images
fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    
    /// Load an image from remote service with cache implementing
    /// - Parameters:
    ///   - urlString: a string image url
    ///   - cached: a boolean that set cache for an image.
    func load(with urlString: String, cached: Bool = false) {

        guard let url = URL(string: urlString)
        else { return }

        // set the image placeholder
        self.image = UIImage(resource: .placeholder)

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        // add activity indicator to image
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()
                }
                return
            }

            DispatchQueue.main.async { [weak self] in
                if let image = UIImage(data: data!) {
                    
                    // save image in cache
                    imageCache.setObject(image, forKey: urlString as NSString)
                    
                    // set image
                    self?.image = image

                    // remove indicator
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}
