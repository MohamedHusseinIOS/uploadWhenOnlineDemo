//
//  GalleryViewController.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    let viewModel = GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
