//
//  CatalogService.swift
//  yourProjectName
//
//  Created by Vladimir on 04.12.2023.
//

import Foundation
// enum для пробрасывания ошибок
enum NetworkError: Error {
    case urlError
    case emptyData
}
final class CatalogService {
    private init() {} // singleton
    static let shared = CatalogService() // singleton

    //(completion: @escaping (Result<CatalogService, Error>) -> Void) - замыкание
    // (Result<CatalogService, Error>) - принимает 1 из двух состояний CatalogService или Error
    func getCatalogData(with albumNumber: String?, price: String?, completion: @escaping (Result<[CatalogApiModel], Error>) -> Void) {

        var urlString = "http://192.168.1.112:8000/bouquets/"
        
        if let albumNumber = albumNumber {
            urlString += "?q=\(albumNumber)"
        }

        if let price = price {
            urlString += "&price=\(price)"
        }
//
//        guard let url = URL(string: urlString) else {
//           
//            completion(.failure(NetworkError.urlError))
//            return
//        }
        guard let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlStringEncoded) else {
            print("url error")
            completion(.failure(NetworkError.urlError))
            return
        }

//        
//        guard let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//              let url = URL(string: urlString) else {
//            print("url error")
//            completion(.failure(NetworkError.urlError))
//            return
//        }
//        print("urlString", urlString)

        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in  // completionHandler – замыкание для обработки  данных  в другом слое (в данном случае  view controller)
            //if let, guard let - разные виды развертывания опционала
            if let error = error {
                print("error") // внутри error != nil
                completion(.failure(error))
            }
            // снаружи error == nil
                           
            guard let data = data else {
                completion(.failure(NetworkError.emptyData)) // внутри data == nil
                return
            }
            // снаружи data != nil

            do {
                let catalogData = try JSONDecoder().decode([CatalogApiModel].self, from: data) //декодируем json в созданную струткру с данными
                completion(.success(catalogData))
            } catch let error {
                completion(.failure(error))
            }
        }).resume() // запускаем задачу
    }
}
