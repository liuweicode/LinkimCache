//
//  LinkimCache.swift
//  LinkimCache
//
//  Created by 刘伟 on 23/12/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import UIKit
import Kingfisher

public final class LinkimCache<CachedBase> {
    public let cachedBase: CachedBase
    public init(_ cachedBase: CachedBase) {
        self.cachedBase = cachedBase
    }
}

public protocol LinkimCacheCompatible {
    associatedtype LinkimCompatibleType
    var lm: LinkimCompatibleType { get }
}

public extension LinkimCacheCompatible {
    public var lm: LinkimCache<Self> {
        get { return LinkimCache(self) }
    }
}

extension UIImageView: LinkimCacheCompatible { }

extension LinkimCache where CachedBase: UIImageView {

    func setImageWithURL(with urlString: String, placeholder: Image? = nil)
    {
        guard let url = URL(string: urlString) else {
            return
        }
        
        self.setImageWithURL(with: url, placeholder: placeholder)
    }

    func setImageWithURL(with url: URL, placeholder: Image? = nil)
    {
        let downloader = ImageDownloader(name: "huge_image_downloader")
        downloader.downloadTimeout = 30
        
        let cachePath = NSHomeDirectory() + "/Library/Caches/linkim_image_cache"
        let cache = ImageCache(name: "cn.com.linkim.cache", path: cachePath)
        cache.maxDiskCacheSize = UInt(60 * 60 * 24 * 30)
        
        let originImageView: UIImageView = self.cachedBase
        originImageView.kf.indicatorType = .activity
        originImageView.kf.setImage(with: ImageResource(downloadURL: url), placeholder: placeholder, options: [.downloader(downloader), .targetCache(cache), .transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
}








