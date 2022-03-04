//
//  GalleryCellViewModel.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation


class GalleryCellViewModel {
    var imageData: Data?
    var imageUrl: String?
    var imageDescription: String
    
    init?(galleryItem: GalleryItem) {
        imageData = galleryItem.imageData
        imageUrl = galleryItem.urls?.small
        imageDescription = galleryItem.description ?? "No description for photo"
    }
}
