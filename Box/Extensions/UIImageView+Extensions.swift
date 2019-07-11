//
//  UIImageView+Extensions.swift
//  Forest
//
//  Created by wookeon on 14/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit
import Kingfisher

// Kingfisher를 이용하여 url로부터 이미지를 가져오는 extension
extension UIImageView {
    public func imageFromUrl(_ urlString: String?,_ defaultImage: String? = "loadingImg") {
        let defaultImg = UIImage(named: defaultImage!)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                let url2: URL = URL(string: url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed)!)!
                self.kf.setImage(with: url2, placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = defaultImg
        }
    }
}
