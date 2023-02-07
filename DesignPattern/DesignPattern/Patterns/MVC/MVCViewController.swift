//
//  MVCViewController.swift
//  DesignPattern
//
//  Created by LeeJiSoo on 2023/02/07.
//

import UIKit

class MVCViewController: UIViewController {

    // MARK: - property

    private lazy var resetButton = UIBarButtonItem(title: "Reset",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(resetData))
    private lazy var addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(addData))
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MVCTableViewCell.self, forCellReuseIdentifier: "MVCTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()

    // MARK: - Model

    var tempArr = [String]()
    var arrCnt = 0

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableViewDelegate()
        setupLayout()
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

    @objc func addData(_ sender: UIBarButtonItem) {
        arrCnt += 1
        tempArr.append("\(arrCnt)번째 데이터 추가")
        tableView.reloadData()
    }

    @objc func resetData(_ sender: UIBarButtonItem) {
        arrCnt = 0
        tempArr = []
        tableView.reloadData()
    }
}

// MARK: - tableview delegate
extension MVCViewController: UITableViewDelegate { }

// MARK: - tableview datasource
extension MVCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MVCTableViewCell", for: indexPath) as? MVCTableViewCell else { return UITableViewCell() }
        cell.setData(tempArr[indexPath.item])
        return cell
    }
}

// MARK: - 데이터 reload 될 떄 스크롤까지 함게 reload되는 것 해결 (앞에다가 데이터가 추가될떄 사용할 수 있음, reloadData대신 이거 사용)
extension UITableView {
    func reloadDataAndKeepOffset() {
        setContentOffset(contentOffset, animated: false)
        let beforeContentSize = contentSize
        reloadData()
        layoutIfNeeded()
        let afterContentSize = contentSize
        let newOffset = CGPoint(x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
                                y: contentOffset.y + (afterContentSize.height - beforeContentSize.height))
        setContentOffset(newOffset, animated: false)
    }
}
