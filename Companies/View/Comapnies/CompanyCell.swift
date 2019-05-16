//
//  CompanyCell.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    var company: Company?{
        didSet{
            var text = ""
            if let name = company?.name{
                text += name
            }
            if let founded = company?.founded{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let date = dateFormatter.string(from: founded)
                text += " - \(date)"
            }
            
            nameFoundedDateLabel.text = text
            nameFoundedDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
            nameFoundedDateLabel.textColor = .white
            backgroundColor = .tealColor
            
            if let imageData = company?.imageData, let image = UIImage(data: imageData){
                companyImageView.image = image
            }else{
                companyImageView.image = #imageLiteral(resourceName: "NoImage")
            }
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "NoImage"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "COMPANY NAME"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(companyImageView)
        addSubview(nameFoundedDateLabel)
        
        NSLayoutConstraint.activate([
            companyImageView.widthAnchor.constraint(equalToConstant: 40),
            companyImageView.heightAnchor.constraint(equalToConstant: 40),
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            nameFoundedDateLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8),
            nameFoundedDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameFoundedDateLabel.topAnchor.constraint(equalTo: topAnchor),
            nameFoundedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
