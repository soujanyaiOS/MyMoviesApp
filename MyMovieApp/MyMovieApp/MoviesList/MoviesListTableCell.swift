//
//  MoviesListTableCell.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 16/03/23.
//

import UIKit
//import SDWebImage
class MoviesListTableCell: UITableViewCell {
    
    fileprivate var viewModel = MovieViewModel()
    
    let placeholderImage = UIImage(named: "placeholder")
    var results = [MovieDetails]()

    let movieImageView:UIImageView = {
        let img = UIImageView()
        //img.imageCorners(20)
        return img
    }()
    
    class var identifier: String { return String(describing: MoviesListTableCell.self)}
    
    var cellViewModel: MoviesCellViewModel? {
        didSet {
            movieTitleLabel.text = cellViewModel?.title
           
          
        }
    }
    
    let movieTitleLabel = MyLabel()
    let containerView = MyView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(movieImageView)
        containerView.addSubview(movieTitleLabel)
        self.contentView.addSubview(containerView)
        contentView.backgroundColor = .clear
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:2).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:1).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-2).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-2).isActive = true
        
        movieImageView.centerYAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        movieTitleLabel.centerYAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo:self.movieImageView.trailingAnchor, constant: 10).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
       // containerView.backgroundColor = UIColor.bgGrayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    func configureCell(indexPath : IndexPath, viewModelObj : MovieViewModel) {
//        viewModel = viewModelObj
//        let result = viewModel.output.getCellObject(indexPath: indexPath)
//        nameLabel.text = result.0
//        containerView.layer.borderWidth = result.2 == true ? 1.0 : 0.0
//        containerView.layer.borderColor = result.2 == true ? UIColor.blue.cgColor : UIColor.clear.cgColor
//        let urlString = HttpRouter.movieImage.description + result.1
//        self.movieImageView.sd_setImage(with: NSURL(string: urlString as String ) as URL?, placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
//            if( error != nil)
//            {
//                debugPrint("Error loading image" , (error?.localizedDescription)! as String)
//            }
//        })
    //}
    
}
