//
//  SceneDelegate.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 11/30/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScence = (scene as? UIWindowScene) else { return }
        
        let apiService = APIService()
        let apiManager = APIManager(apiService: apiService)
        let interactor = ViewControllerInteractor(apiManager: apiManager)
        
        let router = ViewControllerRouter()
        let presenter = ViewControllerPresenter(todos: [], cancellable: [], interactor: interactor, router: router)
        let viewController = ViewController(presenter: presenter)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        router.viewController = viewController
        
        window = UIWindow(windowScene: windowScence)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

