//
//  ViewControllerRouter.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 12/1/22.
//

import Foundation

struct ViewControllerRouter {
    
    func route(viewController: ViewController, text: String?) {
        let tempViewController = TempViewController(text: text)
        viewController.navigationController?.pushViewController(tempViewController, animated: true)
    }
    
}
