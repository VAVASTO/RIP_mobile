//
//  CustomImageView.swift
//  yourProjectName
//
//  Created by Vladimir on 04.12.2023.
//


import UIKit

final class CustomImageView: UIImageView {
    var currentUrl: URL?
    let shared = ImageManager.shared
    
    func loadImage(with url: URL) {
        currentUrl = url
        shared.loadImage(from: url) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                if self.currentUrl != url {
                    return
                }
                self.image = UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}
