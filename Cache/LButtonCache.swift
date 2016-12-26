//
//  LButtonCache.swift
//  SKFinance
//
//  Created by 刘伟 on 26/12/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import Foundation
import Kingfisher

extension UIButton: LinkimCacheCompatible { }

extension LinkimCache where CachedBase: UIButton {
    
    func setImageWithURL(with urlString: String, placeholder: UIImage? = nil)
    {
        guard let url = URL(string: urlString) else {
            return
        }
        self.setImageWithURL(with: url, placeholder: placeholder, state: .normal)
    }
    
    
    /// Load image from backend server
    ///
    /// - Parameters:
    ///   - url: path of image on server
    ///   - placeholder: default image, It will be displayed when pull image with an error occured
    func setImageWithURL(with url: URL, placeholder: UIImage? = nil, state: UIControlState)
    {
        let originButton: UIButton = self.cachedBase
        
        originButton.kf.setImage(with: ImageResource(downloadURL: url), for: state, placeholder: placeholder, options: [.downloader(LinkimCacheManager.shared.imageDownload), .targetCache(LinkimCacheManager.shared.imageCache), .transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
}
