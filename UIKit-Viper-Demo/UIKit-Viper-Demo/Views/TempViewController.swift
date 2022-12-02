//
//  TempViewController.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 12/1/22.
//

import UIKit

class TempViewController: UIViewController {
    
    private var textLabel: UILabel!
    private var text: String?
    
    init(text: String?) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setup()
    }
    
    private func initViews() {
        textLabel = UILabel()
        view.addSubview(textLabel)
    }
    
    private func setup() {
        view.backgroundColor = .white
        textLabel.text = text
        textLabel.textColor = .systemBlue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textLabel.frame = view.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
