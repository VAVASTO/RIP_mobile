//
//  CatalogViewController.swift
//  yourProjectName
//
//  Created by Vladimir on 16.10.2023.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private let imageManager = ImageManager.shared
    private let model = CatalogModel()
    private var categoryModel: [CatalogApiModel] = []
    private lazy var catalogTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self // подписываемся на протокол
        tableView.dataSource = self  // подписываемся на протокол
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: "CatalogCell") // Identifier: "CatalogCell" - должен совпадать с тем что прописан в реализации делегата
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Список букетов" // устанавливаем заголовок
        view.backgroundColor = .white
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), //создаем ButtonItem для поиска
                                                style: .done,
                                                target: self,
                                                action: #selector(findButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), //создаем ButtonItem для поиска
                                                style: .done,
                                                target: self,
                                                action: #selector(reloaddButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem

        view.addSubview(catalogTableView)
        setupCatalogTableView()
        loadCatalog()
        
    }
    
    @objc
    private func findButtonTapped() {
        // Создаем UIAlertController
        let alertController = UIAlertController(title: "Поиск",
                                                message: nil,
                                                preferredStyle: .alert)

        // Добавляем текстовое поле для типа
        alertController.addTextField { textField in
            textField.placeholder = "Введите название"
        }

        // Добавляем текстовое поле для цены
        alertController.addTextField { textField in
            textField.placeholder = "Введите цену"
            textField.keyboardType = .numberPad // Set keyboard type for numeric input
        }

        // Добавляем кнопку Найти
        let findAction = UIAlertAction(title: "Найти", style: .default) { [weak self] _ in
            // код по обработке введенных данных
            if let searchText = alertController.textFields?.first?.text,
               let priceText = alertController.textFields?.last?.text {
                self?.handleSearch(searchText, price: priceText)
            }
        }

        alertController.addAction(findAction)

        // Добавляем кнопку Отмена
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // Показываем UIAlertController
        present(alertController, animated: true, completion: nil)
    }

    private func handleSearch(_ type: String?, price: String?) {
        print(type )
        // Your existing code to load data based on type and price
        model.loadCatalog(with: type, price: price) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.categoryModel = data
                    self?.catalogTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    @objc
    private func reloaddButtonTapped() {
        loadCatalog()
    }
    
    // задаем отступы (в данном слечае прибито к краям экрана)
    private func setupCatalogTableView() {
        catalogTableView.translatesAutoresizingMaskIntoConstraints = false
        catalogTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        catalogTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        catalogTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        catalogTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func loadCatalog() {
        model.loadCatalog { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.categoryModel = data
                    self?.catalogTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // колечество ячеек в таблице
        categoryModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // создание ячеек
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "CatalogCell", for: indexPath) as? CatalogTableViewCell else {
            return .init()
        }
        cell.cellConfigure(with: categoryModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // меняет размер ячейки
        250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = categoryModel[indexPath.row]

        let detailVC = DetailInformationViewController()

        detailVC.datailConfigure(with: selectedModel)

        navigationController?.pushViewController(detailVC, animated: true)
    }

}



