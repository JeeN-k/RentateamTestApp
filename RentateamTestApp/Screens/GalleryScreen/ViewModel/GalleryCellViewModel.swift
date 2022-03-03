//
//  GalleryCellViewModel.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation


class GalleryCellViewModel: GalleryCellViewModelProtocol {
    var image: String
    var imageDescription: String
    
    init(galleryItem: GalleryItem) {
        image = galleryItem.urls.small
        imageDescription = galleryItem.description ?? "Net"
    }
}
