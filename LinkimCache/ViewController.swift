//
//  ViewController.swift
//  LinkimCache
//
//  Created by 刘伟 on 22/12/2016.
//  Copyright © 2016 上海凌晋信息技术有限公司. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class ViewController: UIViewController {

     let documentPath:String = {
        return NSHomeDirectory() + "/Documents"
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        print("\(documentPath)")
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        //imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: "http://img06.tooopen.com/images/20161112/tooopen_sy_185726882764.jpg")!))
        imageView.lm.setImageWithURL(with: "http://img06.tooopen.com/images/20161112/tooopen_sy_185726882764.jpg")
        
        
        
        
    }
    
   

}

