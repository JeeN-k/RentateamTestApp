//
//  GalleryViewModel.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation

class GalleryViewModel: GalleryViewModelProtocol {
    
    let network: Networking
    let galleryNetwork: GalleryNetwork
    
    var galleryItems = [GalleryItem]()
    var page = 1
    var isPagination = false
    
    init() {
        network = NetworkService()
        galleryNetwork = GalleryNetworkSerivce(networking: network)
    }
    
    func numberOfRows() -> Int {
        return galleryItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GalleryCellViewModelProtocol? {
        let galleryItem = galleryItems[indexPath.item]
        return GalleryCellViewModel(galleryItem: galleryItem)
    }
    
    func getGalleryPhotos(completion: @escaping(() -> Void)) {
        galleryNetwork.getPhotos(page: page) { [weak self] response in
            guard let galleryResponse = response, let self = self else { return }
            if !self.isPagination {
                self.galleryItems = galleryResponse
                self.isPagination = true
            } else {
                self.galleryItems += galleryResponse
            }
            self.page += 1
            completion()
        }
    }
}
