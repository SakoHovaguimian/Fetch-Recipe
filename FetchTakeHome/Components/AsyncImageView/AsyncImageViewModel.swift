//
//  AsyncImageViewModel.swift
//  FetchTakeHome
//
//  Created by Sako Hovaguimian on 2/13/25.
//

import UIKit

class AsyncImageViewModel: ObservableObject {
    
    private let apiService: APIServiceProtocol!
    private let imageCacheService: ImageCacheServiceProtocol!
    
    @Published var image: UIImage?
    
    init() {
        
        self.apiService = APIService()
        self.imageCacheService = ImageCacheService()
        
    }
    
    func loadImage(for id: String,
                   with urlString: String) {
        
        Task { [weak self] in
            
            guard let self = self else { return }
            
            do {
                
                let image = try await self._loadImage(
                    for: id,
                    with: urlString
                )
                
                await MainActor.run { [weak self] in
                    
                    self?.image = image
                    
                }
                
            }
            catch {
                print("ERROR: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    private func _loadImage(for id: String,
                            with urlString: String) async throws -> UIImage? {
        
        if let validURL = URL(string: urlString) {
            
            if let image = self.imageCacheService.image(for: id) {
                
                print("FETCHED FROM CACHE: \(id)")
                return image
                
            }
            
            let image = try await apiService.getImage(url: validURL)
            self.imageCacheService.insertImage(image, for: id)
            
            print("SAVED TO CACHE: \(id)")
            
            return image
            
        }
        
        return nil
        
    }
    
}
