//
//  FetchImageCacheTests.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit
import Testing
@testable import FetchTakeHome

@Suite("Image Cache")
struct FetchImageCacheTests {
    
    private let imageCacheService: ImageCacheServiceProtocol
    
    init() {
        self.imageCacheService = ImageCacheServiceMock()
    }
    
    @Test("Store Cached Image & Fetch")
    func checkIfCacheWorks() async throws {
       
        let image = UIImage(systemName: "pencil")
        self.imageCacheService.insertImage(
            image,
            for: "test_key_1"
        )
        
        let fetchedImage = self.imageCacheService.image(for: "test_key_1")
        #expect(fetchedImage != nil)
        
    }
    
    @Test("Fetch Non-Existent Key")
    func checkFetchForMissingKey() async throws {
        
        let fetchedImage = imageCacheService.image(for: "random_key")
        #expect(fetchedImage == nil)
        
    }
    
    @Test("Overwrite Existing Key")
    func checkOverwriteBehavior() async throws {
        
        let firstImage = UIImage(systemName: "pencil")
        let secondImage = UIImage(systemName: "trash")
        
        imageCacheService.insertImage(firstImage, for: "test_key")
        imageCacheService.insertImage(secondImage, for: "test_key")
        
        let fetchedImage = imageCacheService.image(for: "test_key")
        #expect(fetchedImage == secondImage)
        
    }

}

