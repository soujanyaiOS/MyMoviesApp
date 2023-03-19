//
//  DetailsViewController.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 13/03/23.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    var viewModel =  MovieViewModel()
    let label = UILabel()
    var stack = UIStackView()
    let placeholderImage = UIImage(named: "placeholder")
    var imageBgView = UIView()
    let movieImageView:UIImageView = {
        let img = UIImageView()
        img.imageCorners(40)
        img.translatesAutoresizingMaskIntoConstraints = true
        return img
    }()
    
    var nameLabel = MyLabel()
    var descriptionLabel = MyLabel()
    var ratingLabel = MyLabel()
    var dateLabel = MyLabel()
    var originalLanguageLabel = MyLabel()
    var bottomLabel = MyLabel()
    
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = true
        [self.descriptionLabel,
         self.ratingLabel,
         self.dateLabel,
         self.originalLanguageLabel,self.bottomLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    var movieItem: MovieDetails? {
        didSet {
            
            descriptionLabel.attributedText = String(format: "Description : %@",movieItem?.overview ?? "").withBoldText(text: "Description :")
            ratingLabel.attributedText = String(format: "Rating : %f",movieItem?.rating ?? 0.0).withBoldText(text: "Rating :")
            dateLabel.attributedText =  String(format: "Date : %@", movieItem?.release_date ?? "").withBoldText(text: "Date :")
            originalLanguageLabel.attributedText = String(format: "Language : %@", movieItem?.original_language ?? "").withBoldText(text: "Language :")
            
            nameLabel.text = movieItem?.title
            let endpoint = APIEndpoint.movieImage(id: movieItem?.backdrop_path ?? "")
            
            self.movieImageView.sd_setImage(with: endpoint.url, placeholderImage: placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                if( error != nil) {
                    debugPrint("Error loading image" )
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let frameWidth = self.view.frame.width/2
        let frameHeight = self.view.frame.height/3.5
        imageBgView .frame = CGRect(x: frameWidth - 100, y: 100, width: 200, height: frameHeight)
        imageBgView.layer.cornerRadius = 10.0
        imageBgView.backgroundColor = .lightGray
        self.view.addSubview(imageBgView)
        
        movieImageView .frame = CGRect(x: 60, y:10, width: 80, height: 80)
        imageBgView.addSubview(movieImageView)
        nameLabel .frame = CGRect(x: imageBgView .frame.width/2 - 70, y:80, width: 150, height: 100)
        nameLabel.textAlignment = .center
        imageBgView.addSubview(nameLabel)
        self.view.addSubview(detailsStackView)
        
        detailsStackView.anchorView(top: movieImageView.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, paddingTop: self.view.frame.height/4, paddingLeft: 10, paddingRight: 10, bottom: view.bottomAnchor)
    }
    
    
}
