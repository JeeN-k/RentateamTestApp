//
//  GalleryModel.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation

struct GalleryItem: Codable {
    var id: String
    var description: String?
    var createdAt: String
    var urls: PhotoUrls?
    var imageData: Data?
}

extension GalleryItem {
    init(record: Photo) {
        id = record.id ?? ""
        description = record.descript
        createdAt = record.date ?? ""
        imageData = record.image
    }
}

struct PhotoUrls: Codable {
    var small: String
    var regular: String
}
