//
//  HorizontalCollectionViewCell.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 17/03/23.
//

import UIKit
import SDWebImage

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    let placeholderImage = UIImage(named: "placeholder")
    var imageSuffixName = ""
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieImageView:UIImageView = {
        let img = UIImageView()
        img.imageCorners(20)
        return img
    }()
    
    var cellViewModel: MovieDetails? {
        didSet {
            nameLabel.text = cellViewModel?.title
            let endpoint = APIEndpoint.movieImage(id: cellViewModel?.poster_path ?? "")
            
            self.movieImageView.sd_setImage(with: endpoint.url, placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                if( error != nil)
                {
                    debugPrint("Error loading image" )
                }
            })
        }
    }
    
    class var identifier: String { return String(describing: HorizontalCollectionViewCell.self)}
    let containerView = MyView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(movieImageView)
        self.contentView.addSubview(containerView)
        
        containerView.anchorView(top: self.contentView.topAnchor, left: self.contentView.leadingAnchor, right: self.contentView.trailingAnchor, paddingTop: 2, paddingLeft: 2, paddingRight: 2, bottom: self.contentView.bottomAnchor)
        
        movieImageView.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 15).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,  constant: -35).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        movieImageView.center = self.containerView.center
        containerView.backgroundColor = .lightGray
        
        nameLabel.anchorView(top: self.movieImageView.bottomAnchor, left: self.containerView.leadingAnchor, right: self.containerView.trailingAnchor, paddingTop: 0, paddingLeft: 5, paddingRight: 5, bottom: self.contentView.bottomAnchor)
        
    }
    
    
}

