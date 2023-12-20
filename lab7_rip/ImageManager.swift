//
//  ImageManager.swift
//  yourProjectName
//
//  Created by Vladimir on 04.12.2023.
//

import Foundation

enum ImageManagerErrors: Error {
    case unexpectedError
}

protocol ImageManagerDescription {
    func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class ImageManager: ImageManagerDescription {

    static let shared = ImageManager()
    private init() {}

    private let networkImageQueue = DispatchQueue(label: "networkImageQueue", attributes: .concurrent)

    func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let mainTreadCompletion: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        networkImageQueue.async {
            guard let imageData = try? Data(contentsOf: url) else {
                mainTreadCompletion(.failure(ImageManagerErrors.unexpectedError))
                return
            }
            mainTreadCompletion(.success(imageData))
        }
    }
}
