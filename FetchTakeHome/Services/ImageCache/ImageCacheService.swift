//
//  ImageCacheService.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

import UIKit

final class ImageCacheService: ImageCacheServiceProtocol {
    
    private let fileManager = FileManager.default
    private var cacheDirectory: URL!
    
    init() {
        setupCacheDirectory()
    }
    
    // MARK: - PUBLIC -
    
    func image(for id: String) -> UIImage? {
        
        let fileURL = cacheDirectory.appendingPathComponent(id)
        
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        return UIImage(data: data)
        
    }
    
    func insertImage(_ image: UIImage?,
                     for id: String) {
        
        let fileURL = cacheDirectory.appendingPathComponent(id)
        
        if let pngData = image?.pngData() {
            
            do {
                try pngData.write(to: fileURL)
            } catch {
                print("Error writing PNG file to disk: \(error)")
            }
            
        }
        
    }
    
    // MARK: - PRIVATE -
    
    private func setupCacheDirectory() {
        
        guard let baseURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            
            print("Could not locate the Caches directory.")
            return
            
        }
        
        let directoryName = "ImageCache"
        let directoryURL = baseURL.appendingPathComponent(directoryName, isDirectory: true)
        
        if !fileManager.fileExists(atPath: directoryURL.path) {
            
            do {
                
                try fileManager.createDirectory(
                    at: directoryURL,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                
            } catch {
                print("Could not create DiskImageCache directory: \(error)")
            }
            
        }
        
        self.cacheDirectory = directoryURL
        
    }
    
}
