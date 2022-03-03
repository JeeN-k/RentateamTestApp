//
//  GalleryNetworkService.swift
//  RentateamTestApp
//
//  Created by Oleg Stepanov on 02.03.2022.
//

import Foundation

protocol GalleryNetwork {
    func getPhotos(page: Int, completion: @escaping (([GalleryItem]?) -> Void))
}

class GalleryNetworkSerivce: GalleryNetwork {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getPhotos(page: Int, completion: @escaping (([GalleryItem]?) -> Void)) {
        let params = ["page": String(page), "per_page": "20", "client_id": "WNniWllK33mO87eCRpdihdlE-1PLPsq3YlmkmvJrF0w"]
        let api = APIS.galleryList.getAPI()
        networking.getRequest(api: api, parameters: params) { data, error in
            if let error = error {
                print("Error recieve data \(error.localizedDescription)")
                completion(nil)
            }
            let response = self.decodeJSON(type: [GalleryItem].self, from: data)
            completion(response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    
}


