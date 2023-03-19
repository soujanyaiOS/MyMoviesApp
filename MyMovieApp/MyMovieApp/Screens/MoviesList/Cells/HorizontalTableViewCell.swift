//
//  HorizontalTableViewCell.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 17/03/23.
//

import UIKit


protocol HorizontalTableViewCellDelegate: AnyObject {
    func movieCellHorizontalDelegate( didselect item: MovieDetails)
}

class HorizontalTableViewCell: UITableViewCell {
    class var identifier: String { return String(describing: HorizontalTableViewCell.self)}
    var cellViewModel: [MovieDetails]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var favourites = [MovieDetails]()
    var onTap: (() -> ())? = nil
    var collectionView: UICollectionView!
    weak var delegate: HorizontalTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 115, height: 120)
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(
            frame: self.frame,
            collectionViewLayout: layout)
        contentView.backgroundColor = .clear
        self.collectionView.isScrollEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        
        self.collectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "HorizontalCollectionViewCell")
        self.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .clear
        contentView.isUserInteractionEnabled = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.anchorView(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leadingAnchor, right: self.safeAreaLayoutGuide.trailingAnchor, paddingTop: 5, paddingLeft: 10, paddingRight: 10, bottom: self.safeAreaLayoutGuide.bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - UICollectionViewDataSource
extension HorizontalTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.cellViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as! HorizontalCollectionViewCell
        cell.cellViewModel =  cellViewModel?[indexPath.item]
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellVM = cellViewModel?[indexPath.item] ?? MovieDetails()
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.black
        }
        delegate?.movieCellHorizontalDelegate(didselect: cellVM)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top:10, left: 10, bottom: 10, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Reset the background color of the deselected cell
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.clear
        }
    }
    
}

