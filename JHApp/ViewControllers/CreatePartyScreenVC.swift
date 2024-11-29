//
//  CreatePartyScreenVC.swift
//  JHApp
//
//  Created by Егорио on 27.11.2024.
//

import UIKit

class CreatePartyScreenVC: UIViewController {

    private let label = TitleLabel(text: "Экран создания звонка")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Styles.Colors.appBackgoundColor
        
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        
        view.addSubview(label)
        
    }
    
    private func setupConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
}
