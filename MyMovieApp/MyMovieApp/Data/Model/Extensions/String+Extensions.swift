//
//  String+Extensions.swift
//  MyMovieApp
//
//  Created by soujanya Balusu on 17/03/23.
//

import UIKit
extension String {
    var asURL: URL? {
        return URL(string: self)
    }
    
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
      let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
      let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize),NSAttributedString.Key.foregroundColor: UIColor.blue]
      let range = (self as NSString).range(of: text)
      fullString.addAttributes(boldFontAttribute, range: range)
        
      return fullString
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
            let size = CGSize(width: width, height: .greatestFiniteMagnitude)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = self.boundingRect(with: size, options: options, attributes: attributes, context: nil).height
            return ceil(rectangleHeight)
        }
}
