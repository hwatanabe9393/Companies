//
//  CreateEmployeeView.swift
//  Companies
//
//  Created by Hikaru Watanabe on 5/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CreateEmpoyeeView: UIView {
    let padding:CGFloat = 12
    
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
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Birthday"
        label.sizeToFit()
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.placeholder = "MM/DD/yyyy"
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel,nameTextField])
        nameStackView.axis = .horizontal
        nameStackView.spacing = padding
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let birthdayStackView = UIStackView(arrangedSubviews: [birthdayLabel, birthdayTextField])
        birthdayStackView.axis = .horizontal
        birthdayStackView.spacing = padding
        birthdayStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = max(nameLabel.frame.width, birthdayLabel.frame.width)
        let height = max(nameLabel.frame.height, birthdayLabel.frame.height)
        
        let stackView = UIStackView(arrangedSubviews: [nameStackView, birthdayStackView])
        stackView.axis = .vertical
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1*padding),
            
            nameLabel.widthAnchor.constraint(equalToConstant: width),
            nameLabel.heightAnchor.constraint(equalToConstant: height),
            
            birthdayLabel.widthAnchor.constraint(equalToConstant: width),
            birthdayLabel.heightAnchor.constraint(equalToConstant: height)
            ])
    }
}
