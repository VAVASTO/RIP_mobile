//
//  DetailInformationViewController.swift
//  yourProjectName
//
//  Created by Vladimir on 11.12.2023.
//

import UIKit

class DetailInformationViewController: UIViewController {
    private let priceLabel: UILabel = UILabel()
    private let  titleLabel: UILabel = UILabel()
    private let  descriptionaLabel: UILabel = UILabel()
    private let photoImageView = CustomImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        [photoImageView,descriptionaLabel, priceLabel,titleLabel].forEach {
            view.addSubview($0)
        }
        
        setVisualAppearance()
        setupImage()
        setPriceLabel()
        setDescriptionLabel()
        setTitleLabel()
    }
}

//MARK: - methods
extension DetailInformationViewController {
    func datailConfigure(with model: CatalogApiModel) {
        print(model.full_url)
//        let image_url_after_serializer = "http://127.0.0.1:9000/" + model.image_url_after_serializer
//        print("model.image_url_after_serializer", model.image_url_after_serializer)
//        print("image_url_after_serializer", image_url_after_serializer)
        guard let photoUrl = URL(string: model.full_url) else {
            return
        }
        
        photoImageView.loadImage(with: photoUrl)
        titleLabel.text = model.name
        priceLabel.text = "Цена товара:" + model.price
        descriptionaLabel.text = model.description
    }
}

//MARK: - private methods
private extension DetailInformationViewController {
    func setVisualAppearance() {
        photoImageView.contentMode = .scaleAspectFit // обрезаем фото
        photoImageView.clipsToBounds = true
        [descriptionaLabel, titleLabel].forEach {
            $0.numberOfLines = 0
            $0.font = UIFont(name: "Times New Roman", size: 20) // меняем шрифт
        }
        priceLabel.font = UIFont(name: "Times New Roman", size: 20) // меняем шрифт
    }
    
    func setupImage() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        titleLabel.sizeToFit()
    }
    
    func setPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        priceLabel.sizeToFit()
    }
    
    func setDescriptionLabel() {
        descriptionaLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionaLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50).isActive = true
        descriptionaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionaLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        descriptionaLabel.sizeToFit()
    }
}
