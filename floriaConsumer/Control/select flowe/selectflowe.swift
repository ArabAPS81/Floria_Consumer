//
//  selectflowe.swift
//  floriaConsumer
//
//  Created by mac on 11/21/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class selectflowe: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flower", for: indexPath) as!  ProductCollectionViewCell
    cell.image.layer.cornerRadius = 20
    cell.image.clipsToBounds = true
    return cell
}


@IBAction func go(_ sender: Any) {
    self.performSegue(withIdentifier: "proudct", sender: nil)
}
override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
}
}
