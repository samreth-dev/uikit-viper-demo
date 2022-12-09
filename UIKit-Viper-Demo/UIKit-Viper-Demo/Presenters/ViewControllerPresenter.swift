//
//  ViewControllerPresenter.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 12/1/22.
//

import Foundation

protocol ViewControllerPresenterProtocol {
    var todos: [Todo] { get set }
    var publisher: Published<[Todo]>.Publisher { get }
    func didInit()
    func didClick(row: Int)
}

class ViewControllerPresenter: ViewControllerPresenterProtocol {
    @Published var todos: [Todo]
    var publisher: Published<[Todo]>.Publisher { $todos }
    private let interactor: ViewControllerInteractorProtocol
    private let router: ViewControllerRouterProtocol
    
    init(todos: [Todo], interactor: ViewControllerInteractorProtocol, router: ViewControllerRouterProtocol) {
        self.todos = todos
        self.interactor = interactor
        self.router = router
    }
    
    func didInit() {
        Task { [weak self] in
            do {
                self?.todos = try await self?.interactor.getTodos() ?? []
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func didClick(row: Int) {
        router.route(text: todos[row].title)
    }
}
