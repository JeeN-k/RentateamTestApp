//
//  GalleryViewModel.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation
import UIKit

class GalleryViewModel {
    
    let network: Networking
    let galleryNetwork: GalleryNetwork
    let coreDataManager: CoreDataManager
    
    var galleryItems = [GalleryItem]()
    var isOfflineMode = false
    var title = "Infinity gallery"
    var pageNum = 1
    var isPagination = false
    
    init() {
        network = NetworkService()
        galleryNetwork = GalleryNetworkSerivce(networking: network)
        coreDataManager = CoreDataManager()
    }
    
    func numberOfRows() -> Int {
        return galleryItems.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GalleryCellViewModel? {
        let galleryItem = galleryItems[indexPath.item]
        return GalleryCellViewModel(galleryItem: galleryItem)
    }
    
    func getGalleryPhotos(completion: @escaping(() -> Void)) {
        galleryNetwork.getPhotos(page: pageNum) { [weak self] galleryResponse, isOffineMode in
            guard let galleryResponse = galleryResponse, let self = self else { return }
            self.isOfflineMode = isOffineMode
            if isOffineMode {
                self.offlineModeWork(galleryResponse: galleryResponse)
            } else {
                self.onlineModeWork(galleryResponse: galleryResponse)
            }
            completion()
        }
    }
    
    func makeDetailViewController(indexPath: IndexPath) -> UIViewController {
        let photoItem = galleryItems[indexPath.item]
        let viewModel = PhotoDetailViewModel(galleryItem: photoItem)
        guard let viewModel = viewModel else { return UIViewController() }
        let viewController = PhotoDetailViewController(viewModel: viewModel)
        return viewController
    }
    
    private func offlineModeWork(galleryResponse: [GalleryItem]) {
        self.galleryItems = galleryResponse
    }
    
    private func onlineModeWork(galleryResponse: [GalleryItem]) {
        if !self.isPagination {
            DispatchQueue.global().async {
                self.coreDataManager.removeAllRecords()
            }
            
            self.galleryItems = galleryResponse
            self.isPagination = true
        } else {
            self.galleryItems += galleryResponse
        }
        
        DispatchQueue.global().async {
            self.coreDataManager.saveGallery(galleryResponse: galleryResponse)
        }
        self.pageNum += 1
    }
    
    
}
