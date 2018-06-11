//
//  CollectionViewController.swift
//  genicMap-SAMPLE
//
//  Created by okumura reo on 2018/06/09.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension CollectionViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (Global.sharedObject().instagramData?.data.count)!
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell:UICollectionViewCell =
      collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                         for: indexPath)
    let imageView = cell.contentView.viewWithTag(1) as! UIImageView
    imageView.image = UIImage(named: (Global.sharedObject().instagramData?.data[indexPath.row].image.url)!)
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage(_:))))
    return cell
  }
  
  // 画像タップ時のイベント
  // TODO: 画像を拡大表示したい
  @objc private func tapImage(_ sender: UITapGestureRecognizer) {
    if let imageView = sender.view as? UIImageView {
      print(imageView)
    }
  }
}
