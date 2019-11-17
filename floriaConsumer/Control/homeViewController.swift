//
//  homeViewController.swift
//  Alamofire
//
//  Created by macbookpro on 7/15/19.
//

import UIKit



class homeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.performSegue(withIdentifier: "proudct", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var x = 5
        if collectionView == Products
        {
            return 10
       
            
        }
        if collectionView == Offers
        {
              return 10
            
            
        }
      
        
        return x
        
    }
    
    @IBAction func readymade(_ sender: Any) {
        self.performSegue(withIdentifier: "listvendor", sender: nil)
    }
    
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
    
    
    
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
    
   
    
if collectionView == SliderHome
    {
    let colWidth=SliderHome.frame.width

    let itemwidth=(colWidth)
        
    return CGSize(width: itemwidth, height:self.SliderHome.frame.size.height)
    }
    else if collectionView == Products
    {
    let colWidth=130

    let itemwidth=(colWidth)
     return CGSize(width:itemwidth,height:160)
    }
    else
    {
        let colWidth=130
        
        let itemwidth=(colWidth)
        return CGSize(width:itemwidth,height:160)
        }
    }
  
    //henaCode
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
        if collectionView == SliderHome
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderHome", for: indexPath) as! SliderHomeCollectionViewCell
             
        
            
        return cell;
        }
       
       
        else if collectionView == Products
        {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Products", for: indexPath) as? ProductCollectionViewCell
            
//
        cell?.viewOfProductsImags.clipsToBounds = true
        let path = UIBezierPath(roundedRect: (cell?.viewOfProductsImags.bounds)!,byRoundingCorners: [.bottomLeft,.bottomRight],cornerRadii: CGSize(width:
            10, height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
        cell?.viewOfProductsImags.layer.mask = maskLayer
            
        let path2 = UIBezierPath(roundedRect: (      cell?.bounds)!,byRoundingCorners: [.topRight,.topLeft],cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer2 = CAShapeLayer()
            
            maskLayer2.path = path2.cgPath
            cell?.layer.mask = maskLayer2
            cell?.clipsToBounds = true
      
        return cell!;
        }
        else
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offers", for: indexPath) as? OffersCollectionViewCell
            

    cell?.ViewOfOffersProduct.clipsToBounds = true
    let path = UIBezierPath(roundedRect: (      cell?.ViewOfOffersProduct.bounds)!,byRoundingCorners: [.bottomLeft,.bottomRight],cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            cell?.ViewOfOffersProduct.layer.mask = maskLayer
            
            
            
        let path2 = UIBezierPath(roundedRect: (      cell?.bounds)!,byRoundingCorners: [.topRight,.topLeft],cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer2 = CAShapeLayer()

            maskLayer2.path = path2.cgPath
            cell?.layer.mask = maskLayer2
            cell?.clipsToBounds = true

        return cell!;
        }
        
    }


override func viewDidLoad()
{
    

super.viewDidLoad()
   
    readymade.layer.cornerRadius = 23
    assemd.layer.cornerRadius = 23
    home.layer.cornerRadius = 23
    car.layer.cornerRadius = 23
    gerb.layer.cornerRadius = 23
}
  

    
    
    
    
}

