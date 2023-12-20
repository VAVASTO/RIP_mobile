//
//  CatalogApiModel.swift
//  yourProjectName
//
//  Created by Vladimir on 04.12.2023.
//

import Foundation

struct CatalogApiModel: Codable {
    let name: String
    let description: String
    let price: String
    let status: String
    var full_url: String
}
