//
//  GalleryViewController.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import UIKit
import RxCocoa

class GalleryViewController: BaseViewController {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    let viewModel = GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configureUI() {
        
    }
    
    func registerCell(){
        let nib = UINib(nibName: GalleryCell.id, bundle: Bundle.main)
        galleryCollectionView.register(nib, forCellWithReuseIdentifier: GalleryCell.id)
    }
    
    func setupCollectionView(){
        galleryCollectionView.delegate = nil
        galleryCollectionView.dataSource = nil
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - CGFloat(10)) / CGFloat(2)
        
        flowLayout.itemSize = CGSize(width: width, height: 286)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset.left = 5
        flowLayout.sectionInset.right = 5
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        galleryCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        galleryCollectionView.scrollsToTop = true
        
        viewModel.output
            .imagesData
            .bind(to: galleryCollectionView.rx.items){ collectionView, item, element in
                let index = IndexPath(item: item, section: 0)
                return self.cellForIndex(index: index, collectionView: collectionView, model: element)
        }.disposed(by: viewModel.bag)
    }
    
    func cellForIndex(index: IndexPath, collectionView: UICollectionView, model: Data) -> GalleryCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.id, for: index) as? GalleryCell else { return GalleryCell() }
        return cell
    }
    
}
