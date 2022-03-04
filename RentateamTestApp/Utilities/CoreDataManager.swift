//
//  CoreDataManager.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 04.03.2022.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    var network: Networking {
        NetworkService()
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RentateamTestApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private func setImageData(url: String, completion: @escaping((Data) ->())) {
        network.getImageData(url: url) { data, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            completion(data)
        }
    }
    
    func saveGallery(galleryResponse: [GalleryItem]?) {
        guard let galleryResponse = galleryResponse else { return }
        
        DispatchQueue.global().async {
            galleryResponse.forEach { galleryItem in
                self.setImageData(url: galleryItem.urls!.small) { [weak self] data in
                    self?.saveItem(galleryItem: galleryItem, imageData: data)
                }
            }
        }
    }
    
    func fetchPhotos(completion: @escaping(([GalleryItem]) -> ())) {
        do {
            let fetchRequest = NSFetchRequest<Photo>(entityName: "Photo")
            let photos = try moc.fetch(fetchRequest)
            let galleryItems = photos.map( { GalleryItem(record: $0) })
            completion(galleryItems)
        } catch {
            print(error)
        }
    }
    
    func removeAllRecords() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Photo")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try moc.execute(batchDeleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func saveItem(galleryItem: GalleryItem, imageData: Data) {
        let photo = Photo(context: moc)
        photo.setValue(galleryItem.description, forKey: "descript")
        photo.setValue(galleryItem.createdAt, forKey: "date")
        photo.setValue(galleryItem.id, forKey: "id")
        photo.setValue(imageData, forKey: "image")
        
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}
