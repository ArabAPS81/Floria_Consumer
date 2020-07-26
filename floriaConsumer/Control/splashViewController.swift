//
//  splashViewController.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class splashViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var GetStartedButton: UIButton!
    @IBOutlet var CollectionViewOfPage: UICollectionView!
    @IBOutlet var CollectionViewOfSides: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView==CollectionViewOfSides
        {
           return introCellFor(collectionView, cellForItemAt: indexPath)
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageController", for: indexPath) as! PagingCell
            return cell;
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != CollectionViewOfSides {
            (collectionView.cellForItem(at: indexPath) as! PagingCell).select()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView != CollectionViewOfSides {
            (collectionView.cellForItem(at: indexPath) as! PagingCell).deselect()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == CollectionViewOfSides {
            return collectionView.frame.size
        }else {
            return CGSize.init(width: 10, height: 10)
        }
    }
    
    
    
    func introCellFor(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlidesCell", for: indexPath) as! IntroCell
        switch indexPath.row {
        case 0:
            cell.imageView.image = UIImage.init(named: "bikeintroicon")
            cell.descLabel.text = "Send flowers to your belovedones wherever they are"
            cell.enDescLabel.text = "أرسل الورد الى احبائك أينما كنت"
            cell.plusView.isHidden = true
        case 1:
            cell.imageView.image = UIImage.init(named: "carintroicon")
            cell.descLabel.text = "Decorate your Car with colorful flowers"
            cell.enDescLabel.text = "زيّن سيارتك بالورود الملونة"
            cell.plusView.isHidden = true
        case 2:
            cell.imageView.image = UIImage.init(named: "marketintroicon")
            cell.descLabel.text = "More than 160 vendors across  Cairo and Giza"
            cell.enDescLabel.text = "أكثر من 160محل ومشتل في  القاهرة والجيزة "
            cell.plusView.isHidden = false
            
        default:
            return UICollectionViewCell()
        }
        
        return cell;
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let x: Int = Int(CollectionViewOfSides.contentOffset.x / CollectionViewOfSides.frame.size.width);
        
       // CollectionViewOfPage.selectItem(at: IndexPath.init(row: x, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        print(x)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x: Int = Int(CollectionViewOfSides.contentOffset.x / CollectionViewOfSides.frame.size.width);
        
        CollectionViewOfPage.selectItem(at: IndexPath.init(row: x, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        print(x)
    }
    var timer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetStartedButton.layer.cornerRadius = 20
        (CollectionViewOfSides.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 0
        
        timer = Timer.init(timeInterval: 0.2, repeats: true) { (t) in
            print(t.timeInterval)
        }
        timer.fire()
        
    }
    
    @IBAction func StartedButton(_ sender: Any) {
        self.performSegue(withIdentifier: "nothere", sender: nil)
    }
}

class IntroCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var enDescLabel: UILabel!
    @IBOutlet weak var plusView: UIStackView!
    
}

class PagingCell: UICollectionViewCell {
    @IBOutlet weak var sImage: UIButton!
    
  func select() {
        sImage.backgroundColor = #colorLiteral(red: 0.9692807794, green: 0, blue: 0.4361249506, alpha: 1)
    }
    
    func deselect() {
        sImage.backgroundColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1)
    }
    
}




extension UIViewController {
   func hideKeyboardWhenTappedAround() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
   }
   @objc func dismissKeyboard() {
       view.endEditing(true)
   }
}
