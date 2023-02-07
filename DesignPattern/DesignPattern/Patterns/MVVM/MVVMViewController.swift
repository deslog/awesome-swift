//
//  MVVMViewController.swift
//  DesignPattern
//
//  Created by LeeJiSoo on 2023/02/07.
//

import Combine
import UIKit

class MVVMViewController: UIViewController {

    // MARK: - property

    private lazy var resetButton = UIBarButtonItem(title: "Reset",
                                                   style: .plain,
                                                   target: self.viewModel,
                                                   action: #selector(viewModel.resetData(_ :)))
    private lazy var addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                                 style: .plain,
                                                 target: self.viewModel,
                                                 action: #selector(viewModel.addData(_ :)))
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MVVMTableViewCell.self, forCellReuseIdentifier: "MVVMTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()

    var disposalbleBag = Set<AnyCancellable>()
    var viewModel: ViewModel = ViewModel()
    var tempArr = [String]()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableViewDelegate()
        setupLayout()
        setBindings()
    }

    // MARK: - func

    private func setupNavigation() {
        navigationItem.title = "MVC"
        navigationItem.leftBarButtonItem = self.resetButton
        navigationItem.rightBarButtonItem = self.addButton
    }

    private func setupTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
    }

    fileprivate func setBindings() {
        // 데이터에 대한 바인딩
        viewModel.$tempArr.sink{ (updatedList: [String]) in
            self.tempArr = updatedList
//            self.tableView.reloadData()
        }.store(in: &disposalbleBag)

        // 액션에 대한 바인딩 (뷰와 관련한 함수 로직도 전부 뷰모델에 있고, 그 액션을 바인딩해주는 방법)
        viewModel.dataUpdateAction.sink{ (addingType: ViewModel.AddingType) in
            print("adding타입은 이것 \(addingType)")
            switch addingType {
            case .add:
                self.tableView.reloadData()
            default:
                self.tableView.reloadData()
            }
        }.store(in: &disposalbleBag)
    }
}

// MARK: - tableview delegate
extension MVVMViewController: UITableViewDelegate { }

// MARK: - tableview datasource
extension MVVMViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MVVMTableViewCell", for: indexPath) as? MVVMTableViewCell else { return UITableViewCell() }
        cell.setData(tempArr[indexPath.item])
        return cell
    }
}
