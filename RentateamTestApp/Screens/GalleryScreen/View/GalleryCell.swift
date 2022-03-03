//
//  GalleryCell.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation
import UIKit

class GalleryCell: UICollectionViewCell {
    
    var viewModel: GalleryCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            descriptionPhoto.text = viewModel.imageDescription
            photoView.set(imageURL: viewModel.image)
        }
    }
    
    lazy var photoView: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.shadowOffset = CGSize(width: 2, height: 4)
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.5
        return image
    }()
    
    lazy var descriptionPhoto: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionPhoto.text = ""
        photoView.image = UIImage()
    }
    
    let identifier = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryCell {
    private func configureConstraints() {
        backgroundColor = .clear
        self.addSubview(photoView)
        self.addSubview(descriptionPhoto)
        
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            photoView.heightAnchor.constraint(equalToConstant: self.bounds.height - 50),
            
            descriptionPhoto.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10),
            descriptionPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionPhoto.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
