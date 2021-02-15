//
//  RGBColor + UIColor.swift
//  Unsplash_API_Test
//
//  Created by taehy.k on 2021/02/16.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
      }
}
