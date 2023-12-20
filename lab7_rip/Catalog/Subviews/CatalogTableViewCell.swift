//
//  CatalogTableViewCell.swift
//  yourProjectName
//
//  Created by Vladimir on 04.12.2023.
//

import UIKit

final class CatalogTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel()
    private let albumLabel: UILabel = UILabel()
    private let photoImageView = CustomImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [photoImageView, titleLabel, albumLabel].forEach {
            addSubview($0)
        }
        setVisualAppearance()
        setupImage()
        setupTitle()
        setupAlbumLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Life circle
extension CatalogTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}

//MARK: - methods
extension CatalogTableViewCell {
    func cellConfigure(with model: CatalogApiModel) {
        print(model.full_url)
        guard let photoUrl = URL(string: model.full_url) else {
            return
        }

        photoImageView.loadImage(with: photoUrl)
        titleLabel.text = model.name
        albumLabel.text = "Цена: " + model.price
    }
}

//MARK: - private methods
private extension CatalogTableViewCell {
    func setVisualAppearance() {
        photoImageView.contentMode = .scaleAspectFit // обрезаем фото
        photoImageView.clipsToBounds = true
        [titleLabel, albumLabel].forEach {
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = UIFont(name: "Times New Roman", size: 17) // меняем шрифт
        }
    }

    func setupImage() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
    }

    func setupAlbumLabel() {
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 15).isActive = true
        albumLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        albumLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        albumLabel.sizeToFit()
    }

    func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        titleLabel.sizeToFit()
    }
}

