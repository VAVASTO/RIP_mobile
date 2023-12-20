//
//  CatalogModel.swift
//  yourProjectName
//
//  Created by Vladimir on 04.12.2023.
//

import Foundation

final class CatalogModel {
    private let catalogNetworkManager = CatalogService.shared
    
    func loadCatalog(with albumId: String? = nil, price: String? = nil, completion: @escaping (Result<[CatalogApiModel], Error>) -> Void) {
        catalogNetworkManager.getCatalogData(with: albumId, price: price) { result in
            completion(result)
        }
    }
}
