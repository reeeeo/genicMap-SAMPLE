//
//  CollectionViewController.swift
//  genicMap-SAMPLE
//
//  Created by okumura reo on 2018/06/09.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource {
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (Global.sharedObject().instagramData?.data.count)!
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:UICollectionViewCell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                         for: indexPath)
    let imageView = cell.contentView.viewWithTag(1) as! UIImageView
    imageView.image = UIImage(named: (Global.sharedObject().instagramData?.data[indexPath.row].image.url)!)
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
