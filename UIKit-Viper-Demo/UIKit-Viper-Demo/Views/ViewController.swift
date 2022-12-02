//
//  ViewController.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 11/30/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var tableView: UITableView!
    private let presenter: ViewControllerPresenter
    private var cancellable: Set<AnyCancellable>
    
    init(presenter: ViewControllerPresenter, cancellable: Set<AnyCancellable>) {
        self.presenter = presenter
        self.cancellable = cancellable
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setup()
        binding()
        presenter.didInit()
    }
    
    private func initViews() {
        tableView = UITableView()
        view.addSubview(tableView)
    }
    
    private func setup() {
        title = "Todo List"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func binding() {
        presenter.$todos.receive(on: DispatchQueue.main).sink { [weak self] todos in
            self?.tableView.reloadData()
        }
        .store(in: &cancellable)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.todos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter.todos[indexPath.row].title
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didClick(row: indexPath.row, viewController: self)
    }
}
