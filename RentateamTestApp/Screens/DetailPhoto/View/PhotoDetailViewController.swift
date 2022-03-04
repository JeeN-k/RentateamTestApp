//
//  PhotoDetailViewController.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 04.03.2022.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {
    
    private lazy var image: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var viewModel: PhotoDetailViewModel?
    
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setData()
    }
    
    func setData() {
        guard let viewModel = viewModel else { return }
        dateLabel.text = viewModel.formatDate(viewModel.createdDate)
        if let imageData = viewModel.imageData {
            image.image = UIImage(data: imageData)
        }
        if let imageUrl = viewModel.imageUrl {
            image.set(imageURL: imageUrl)
        }
    }
}

extension PhotoDetailViewController {
    
    private func configureView() {
        view.backgroundColor = .white
        title = viewModel?.title
        view.addSubview(image)
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            
            dateLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  10),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            
        ])
    }
}
