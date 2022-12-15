//
//  ViewController.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 11/30/22.
//

import UIKit

class ViewController: UIViewController {
    private var tableView: UITableView!
    private var presenter: ViewControllerPresenterProtocol
    
    init(presenter: ViewControllerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setup()
        binding()
        presenter.didInit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//MARK: setups
private extension ViewController {
    func initViews() {
        tableView = UITableView()
        view.addSubview(tableView)
    }
    
    func setup() {
        title = "Todo List"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func binding() {
        presenter.publisher.receive(on: DispatchQueue.main).sink { [weak self] todos in
            self?.tableView.reloadData()
        }
        .store(in: &presenter.cancellable)
    }
}

//MARK: datasource & delegate
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
        presenter.didClick(row: indexPath.row)
    }
}
