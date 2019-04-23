//
//  CompanyModificationView.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CompanyModificationView: UIView {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Name"
        label.sizeToFit()
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.placeholder = "Enter name..."
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    func setLayout(){
        let nameLabelWidth = nameLabel.frame.width
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel,nameTextField])
        nameStackView.axis = .horizontal
        nameStackView.spacing = 16
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nameStackView)
        
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: self.topAnchor),
            nameStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameStackView.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.widthAnchor.constraint(equalToConstant: nameLabelWidth),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
