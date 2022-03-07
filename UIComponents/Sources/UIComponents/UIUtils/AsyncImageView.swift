//
//  File.swift
//  
//
//  Created by Rakesh Patole on 26/02/22.
//

import Foundation
import UIKit

public final class AsyncImageView: UIImageView {
    private var url: URL?
    private static let imageCache = NSCache<NSString, UIImage>()

    public func loadImage(from url: URL?) {
        guard self.url != url else { return }
        self.url = url
        guard let url = self.url else { return }

        if let cachedImage = AsyncImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }

        self.image = nil

        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if error != nil { return }
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard let downloadedImage = UIImage(data: data) else { return }
                guard let urlString = response?.url?.absoluteString else { return }
                AsyncImageView.imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                guard let self = self else { return }
                if self.url == response?.url {
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}
