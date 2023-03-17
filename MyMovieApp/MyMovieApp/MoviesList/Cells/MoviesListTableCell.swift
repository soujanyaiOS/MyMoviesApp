//
//  MoviesListTableCell.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 16/03/23.
//

import UIKit
import SDWebImage
class MoviesListTableCell: UITableViewCell {
    
    fileprivate var viewModel = MovieViewModel()
    let placeholderImage = UIImage(named: "placeholder")
    var results = [MovieDetails]()    
    let movieImageView:UIImageView = {
        let img = UIImageView()
        img.imageCorners(20)
        return img
    }()
    
    class var identifier: String { return String(describing: MoviesListTableCell.self)}
    
    var cellViewModel: MovieDetails? {
        didSet {
            movieTitleLabel.text = cellViewModel?.title
            let endpoint = APIEndpoint.movieImage(id: cellViewModel?.poster_path ?? "")
            
            self.movieImageView.sd_setImage(with: endpoint.url, placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                if( error != nil)
                {
                    debugPrint("Error loading image" )
                }
            })
        }
    }
    
    let movieTitleLabel = MyLabel()
    let containerView = MyView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    private func setUpUI() {
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(containerView)
        containerView.addSubview(movieTitleLabel)
        containerView.addSubview(movieImageView)
        contentView.backgroundColor = .clear
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        
        containerView.anchorView(top: self.contentView.topAnchor, left: self.contentView.leadingAnchor, right: self.contentView.trailingAnchor, paddingTop: 2, paddingLeft: 2, paddingRight: 2, bottom: self.contentView.bottomAnchor)
                
                
        movieTitleLabel.anchorView(top: self.containerView.topAnchor, left: self.movieImageView.trailingAnchor, right: self.contentView.trailingAnchor, paddingTop: 2, paddingLeft: 10, paddingRight: 2, bottom: self.contentView.bottomAnchor)
        
        movieImageView.anchorView(top: self.containerView.topAnchor, left: self.containerView.leadingAnchor, right: self.containerView.leadingAnchor, paddingTop: 2, paddingLeft: 2, paddingRight: self.containerView.frame.width - 45, bottom: self.containerView.bottomAnchor)
        
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
