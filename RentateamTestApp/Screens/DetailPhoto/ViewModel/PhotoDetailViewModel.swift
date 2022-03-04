//
//  PhotoDetailViewModel.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 04.03.2022.
//

import Foundation

class PhotoDetailViewModel {
    
    let title = "Detail"
    
    let imageData: Data?
    let imageUrl: String?
    let createdDate: String
    
    init?(galleryItem: GalleryItem) {
        self.imageData = galleryItem.imageData
        self.imageUrl = galleryItem.urls?.regular
        self.createdDate = galleryItem.createdAt
    }
    
    func formatDate(_ isoDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
