//
//  ViewController.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import UIKit

class GalleryViewController: UIViewController {
    var viewModel: GalleryViewModel!
    var isRefreshing = true
    
    var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 5, height: UIScreen.main.bounds.width / 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    var refresher: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GalleryViewModel()
        
        configureView()
        reloadView()
    }
    
    @objc private func updateRecords() {
        if !viewModel.isOfflineMode {
            viewModel.pageNum = 1
            viewModel.isPagination = false
            reloadView()
        }
    }
    
    private func reloadView() {
        viewModel.getGalleryPhotos {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refresher.endRefreshing()
                self.isRefreshing = false
            }
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GalleryCell
        guard let cell = cell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = viewModel.makeDetailViewController(indexPath: indexPath)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            if !isRefreshing && !viewModel.isOfflineMode {
                isRefreshing = true
                reloadView()
            }
        }
    }
}

extension GalleryViewController {
    private func configureView() {
        
        title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        refresher.tintColor = UIColor.red
        refresher.addTarget(self, action: #selector(updateRecords), for: .valueChanged)
        collectionView.addSubview(refresher)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

