//
//  ViewControllerPresenter.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 12/1/22.
//

import Foundation
import Combine

protocol ViewControllerPresenterProtocol {
    var todos: [Todo] { get set }
    var publisher: Published<[Todo]>.Publisher { get }
    var cancellable: Set<AnyCancellable> { get set }
    
    func didInit()
    func didClick(row: Int)
}

class ViewControllerPresenter {
    @Published var todos: [Todo]
    var publisher: Published<[Todo]>.Publisher { $todos }
    var cancellable: Set<AnyCancellable>
    private let interactor: ViewControllerInteractorProtocol
    private let router: ViewControllerRouterProtocol
    
    init(todos: [Todo], cancellable: Set<AnyCancellable>, interactor: ViewControllerInteractorProtocol, router: ViewControllerRouterProtocol) {
        self.todos = todos
        self.cancellable = cancellable
        self.interactor = interactor
        self.router = router
    }
}

extension ViewControllerPresenter: ViewControllerPresenterProtocol {
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
