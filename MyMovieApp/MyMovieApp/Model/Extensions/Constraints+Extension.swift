//
//  Constraints+Extension.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 16/03/23.
//

import UIKit
extension UIView {
    func anchorView(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, bottom: NSLayoutYAxisAnchor?,  height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingTop).isActive = true
        }
        
        if let height = height {
                   heightAnchor.constraint(equalToConstant: height).isActive = true
               }
    }
}
