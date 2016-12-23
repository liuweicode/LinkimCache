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










