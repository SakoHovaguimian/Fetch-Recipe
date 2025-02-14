//
//  ImageCacheServiceMock.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

final class ImageCacheServiceMock: ImageCacheServiceProtocol {
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func image(for id: String) -> UIImage? {
        
        guard let url = NSURL(string: id) else { return nil }
        return cache.object(forKey: url)
        
    }
    
    func insertImage(_ image: UIImage?, for id: String) {
        
        if let image,
           let url = NSURL(string: id) {
            
            cache.setObject(image, forKey: url)
            
        }
        
    }
    
}
