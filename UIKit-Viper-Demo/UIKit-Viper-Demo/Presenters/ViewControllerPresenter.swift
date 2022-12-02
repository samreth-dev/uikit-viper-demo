//
//  ViewControllerPresenter.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 12/1/22.
//

import Foundation

class ViewControllerPresenter {
    
    @Published var todos: [Todo]
    private let interactor: ViewControllerInteractor
    private let router: ViewControllerRouter
    
    init(todos: [Todo], interactor: ViewControllerInteractor, router: ViewControllerRouter) {
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
    
    func didClick(row: Int, viewController: ViewController) {
        router.route(viewController: viewController, text: todos[row].title)
    }
    
}
