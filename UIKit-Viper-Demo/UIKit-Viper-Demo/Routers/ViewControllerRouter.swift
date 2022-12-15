//
//  ViewControllerRouter.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 12/1/22.
//

import UIKit

protocol ViewControllerRouterProtocol {
    var viewController: UIViewController? { get set }
    func route(text: String?)
}

class ViewControllerRouter {
    var viewController: UIViewController? = nil
}

extension ViewControllerRouter: ViewControllerRouterProtocol {
    func route(text: String?) {
        let tempViewController = TempViewController(text: text)
        viewController?.navigationController?.pushViewController(tempViewController, animated: true)
    }
}
