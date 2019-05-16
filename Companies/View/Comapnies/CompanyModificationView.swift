//
//  CompanyModificationView.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CompanyModificationView: UIView {
    let padding:CGFloat = 12
    
    weak var delegate: ImageSelectDelegate!{
        didSet{
            if let gesture = companyImageView.gestureRecognizers{
                companyImageView.removeGestureRecognizer(gesture.first!)
            }
            let tapGesture = UITapGestureRecognizer(target: delegate, action: #selector(delegate.imageDidTap(_:)))
            companyImageView.addGestureRecognizer(tapGesture)
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "NoImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        return dp
    }()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    func setLayout(){
        let nameLabelWidth = nameLabel.frame.width
        let nameLabelHeight = nameLabel.frame.height
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel,nameTextField])
        nameStackView.axis = .horizontal
        nameStackView.spacing = padding
        let imageStackView = UIStackView(arrangedSubviews: [UIView(), companyImageView, UIView()])
        imageStackView.axis = .horizontal
        imageStackView.spacing = 0
        
        let modificationStackView = UIStackView(arrangedSubviews: [imageStackView, nameStackView, datePicker])
        modificationStackView.axis = .vertical
        modificationStackView.spacing = padding
        modificationStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(modificationStackView)
        
        NSLayoutConstraint.activate([
            modificationStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            modificationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            modificationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1*padding),
            
            companyImageView.heightAnchor.constraint(equalToConstant: 100),
            companyImageView.widthAnchor.constraint(equalToConstant: 100),
            companyImageView.centerXAnchor.constraint(equalTo: modificationStackView.centerXAnchor),
            
            nameLabel.widthAnchor.constraint(equalToConstant: nameLabelWidth),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight),
            
            datePicker.heightAnchor.constraint(equalToConstant: 250)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
