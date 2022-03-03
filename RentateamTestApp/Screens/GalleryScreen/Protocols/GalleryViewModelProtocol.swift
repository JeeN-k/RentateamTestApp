//
//  GalleryViewModelProtocol.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation

protocol GalleryViewModelProtocol {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> GalleryCellViewModelProtocol?
}
