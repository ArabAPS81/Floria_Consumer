//
//  ColorsPopupViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/4/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

protocol ColorsViewDelegate: class {
    func didSelectColor(_ color:CarColor)
}

class ColorsPopupViewController: UIViewController {
    
    weak var delegate: ColorsViewDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var colors: [CarColor]!

    override func viewDidLoad() {
        super.viewDidLoad()
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 8
        setColors()
    }
    
    func setColors() {
        colors = Constants.carColors
    }
    
}
extension ColorsPopupViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.viewWithTag(100)?.backgroundColor = UIColor.init(hexString: colors[indexPath.row].code)
        cell.viewWithTag(100)?.dropRoundedShadowForAllSides(35)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            cell.viewWithTag(100)?.dropRoundedShadowForAllSides(35)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectColor(colors[indexPath.row])
        self.dismiss(animated: true)
    }
}
