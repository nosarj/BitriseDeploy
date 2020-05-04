//
//  UIImageView.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 04/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import UIKit

extension UIImageView {

    func setImage(with url: URL, placeholder: UIImage? = nil, completion: ((UIImage) -> Void)? = nil) {
        if let placeHolderImage = placeholder {
            image = placeHolderImage
        }
        let urlRequest = URLRequest(url: url)
        let downloadTask = ImageLoadingService.shared.loadImageWithURLRequest(urlRequest) { (downloadedImage) in
            DispatchQueue.main.async {
                self.image = downloadedImage
                SimpleDataCache.default.removeObject(forKey: self.hash as AnyObject)
                if let callBack = completion {
                    callBack(downloadedImage)
                }
            }
        }
        guard let task = downloadTask else { return }
        SimpleDataCache.default.setObject(task, forKey: self.hash as AnyObject)
    }

    func cancelImageRequest() {
        if let downloadTask = SimpleDataCache.default.object(forKey: self.hash as AnyObject) as? URLSessionTask {
            downloadTask.cancel()
        }
    }
}
