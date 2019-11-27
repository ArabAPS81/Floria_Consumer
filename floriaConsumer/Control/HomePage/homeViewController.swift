//
//  homeViewController.swift
//  Alamofire
//
//  Created by macbookpro on 7/15/19.
//

import UIKit
import Alamofire
import SwiftyJSON

import Foundation



class homeViewController: UIViewController {
    
    
    
    
    
    
    @IBOutlet var springSale: UIImageView!
    @IBOutlet var search: UIBarButtonItem!
    @IBOutlet var sideMenu: UIBarButtonItem!
    var arrOfServiceImages :[UIImage]!
    var arrOfServiceNames :[String]!
    var arrofimagesinslideer : [UIImage]!
    var arrOfServiceNamesArabic:[String]!
    @IBOutlet var Offers: UICollectionView!
    @IBOutlet var Products: UICollectionView!
    @IBOutlet var SliderHome: UICollectionView!
    
    @IBOutlet weak var readymade: UIButton!
    @IBOutlet weak var assemd: UIButton!
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var car: UIButton!
    @IBOutlet weak var gerb: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readymade.layer.cornerRadius = 23
        assemd.layer.cornerRadius = 23
        home.layer.cornerRadius = 23
        car.layer.cornerRadius = 23
        gerb.layer.cornerRadius = 23
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Products.reloadData()
    }
    
    func registerCells() {
        let nib = UINib.init(nibName: "HomeProductCollectionViewCell", bundle: nil)
        Products.register(nib, forCellWithReuseIdentifier: "HomeProductCollectionViewCell")
        
        let nib2 = UINib.init(nibName: "HomeVendorCollectionViewCell", bundle: nil)
        Offers.register(nib2, forCellWithReuseIdentifier: "HomeVendorCollectionViewCell")
    }
    
    
    @IBAction func readymade(_ sender: Any) {
        self.performSegue(withIdentifier: "listvendor", sender: nil)
    }
    @IBAction func gerb(_ sender: Any) {
        self.performSegue(withIdentifier: "listvendor", sender: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == SliderHome
        {
            let colWidth=SliderHome.frame.width
            
            let itemwidth=(colWidth)
            
            return CGSize(width: itemwidth, height:self.SliderHome.frame.size.height)
        }
        else if collectionView != Products
        {
            return CGSize(width:150,height:190)
        }
        else
        {
            return CGSize(width:150,height:190)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == SliderHome
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderHome", for: indexPath) as! SliderHomeCollectionViewCell
            return cell;
        } else if collectionView == Products {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionViewCell", for: indexPath) as? HomeProductCollectionViewCell
            return cell!;
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVendorCollectionViewCell", for: indexPath) as? HomeVendorCollectionViewCell
            return cell!;
        }
        
    }
    
}

extension homeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
}

