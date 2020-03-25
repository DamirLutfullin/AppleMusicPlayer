//
//  FooterView.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 25.03.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupElements()
    }
    
    func showLoader() {
        loader.startAnimating()
        myLabel.text = "Loading"
    }
    
    func stopLoader() {
        loader.stopAnimating()
        myLabel.text = ""
    }
    
    private func setupElements() {
        addSubview(myLabel)
        addSubview(loader)
        
        loader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        myLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        myLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8).isActive = true
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

}
