//
//  ImageLoadingService.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 03/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import UIKit

class ImageLoadingService {

    static let shared = ImageLoadingService()

    private var activeTask: URLSessionTask?

    func loadImageWithURLRequest(_ request: URLRequest, completion: @escaping (_ image: UIImage) -> Void) -> URLSessionTask? {
        if let image = self.readFromCache(request: request) {
            completion(image)
            return nil
        }

        guard !isRequestEqualToActiveRequest(request) else { return nil }
        activeTask = URLSession.shared.dataTask(with: request) { (data, response, _) in
            do {
                try self.checkHTTPResonse(response)
            } catch {
                print("Image load failed with error")
                return
            }

            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.saveToCache(request: request, image: image)
            completion(image)
        }
        activeTask?.resume()
        return activeTask
    }

    private func isRequestEqualToActiveRequest(_ request: URLRequest) -> Bool {
        if activeTask?.currentRequest == request {
            return true
        }
        return false
    }

    private func checkHTTPResonse(_ response: URLResponse?) throws {
        guard let response = response as? HTTPURLResponse else { throw NetworkError.Unknown }
        if response.statusCode != 200 {
            throw NetworkError.statusCode(statusCode: response.statusCode)
        }
    }

    private func saveToCache(request: URLRequest, image: UIImage) {
        SimpleDataCache.default.setObject(image, forKey: request as NSURLRequest)
    }

    private func readFromCache(request: URLRequest) -> UIImage? {
        return SimpleDataCache.default.object(forKey: request as NSURLRequest) as? UIImage
    }
}

enum SimpleDataCache {

    static let `default`: NSCache<AnyObject, AnyObject> = {
        return NSCache<AnyObject, AnyObject>()
    }()
}
