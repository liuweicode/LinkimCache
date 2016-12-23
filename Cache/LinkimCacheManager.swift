//
//  LinkimCacheManager.swift
//  LinkimCache
//
//  Created by 刘伟 on 23/12/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import UIKit
import Kingfisher

class LinkimCacheManager
{

    // Location of cache path on disk
    static let cachePath:String = {
        return NSHomeDirectory() + "/Library/Caches/linkim_image_cache"
    }()
    
    // Singleton
    static let shared = LinkimCacheManager()
    
    private init() {}
    
    
    // Image downloader defined in Kingfisher
    var imageDownload: ImageDownloader = {
        let downloader = ImageDownloader(name: "cn.com.linkim.ImageDownloader")
        downloader.downloadTimeout = 30
        //downloader.sessionConfiguration.httpAdditionalHeaders
        return downloader
    }()
    
    
    // Image cache defined in Kingfisher
    var imageCache: ImageCache = {
        var cache = ImageCache(name: "cn.com.linkim.ImageCache", path: LinkimCacheManager.cachePath)
        //cache.maxDiskCacheSize = UInt(60 * 60 * 24 * 30)
        return cache
    }()
    
    /// Calculate the disk size taken by cache.
    /// It's the total allocated size of the cached files in bytes
    ///
    /// - Parameter handler: Called with the calculated size when finishes.
    func calculateDiskCacheSize(completion handler:@escaping ((_ size: UInt) -> ()))
    {
        imageCache.calculateDiskCacheSize(completion: handler)
    }
    
    /// Clean memory cache
    func clearMemoryCache()
    {
        imageCache.clearMemoryCache()
    }
    
    /// Clean disk cache, This is an asyn operation.
    ///
    /// - Parameter handler: Called after operation completes
    func clearDiskCache(completion handler: (()->())? = nil)
    {
        imageCache.clearDiskCache(completion: handler)
    }
    
    /// Clean expired disk cache, This is an asyn operation.
    ///
    /// - Parameter handler: Called after operation completes.
    func cleanExpiredDiskCache(completion handler: (()->())? = nil)
    {
        imageCache.cleanExpiredDiskCache(completion: handler)
    }
    
    
}
