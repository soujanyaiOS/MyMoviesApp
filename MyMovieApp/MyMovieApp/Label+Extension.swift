//
//  Label+Extension.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 16/03/23.
//

import UIKit
class MyLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = UIColor.black
        self.numberOfLines = 0
        
    }
    
}

class MyView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    func initializeView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
}
