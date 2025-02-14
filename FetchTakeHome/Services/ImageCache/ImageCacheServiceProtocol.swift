//
//  ImageCacheServiceProtocol.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

protocol ImageCacheServiceProtocol: AnyObject {
    
    func image(for id: String) -> UIImage?
    func insertImage(_ image: UIImage?, for id: String)
    
}
