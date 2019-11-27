//
//  ProductDetailsViewController.swift
//  
//
//  Created by macbookpro on 7/20/19.
//

import UIKit


class ProductDetailsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    var dataaaaa = "" 
    @IBOutlet weak var colorcharacter: UIImageView!
    @IBOutlet weak var sizename: UILabel!
    @IBOutlet weak var colorname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet var back: UIBarButtonItem!
    
    @IBOutlet var Offers: UICollectionView!
    @IBOutlet var Products: UICollectionView!

    @IBOutlet var SliderHome: UICollectionView!
    @IBOutlet weak var providerpic: UIButton!
    @IBOutlet weak var backimg: UIImageView!
    
    
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet var AddToCar: UIButton!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       
        if collectionView == Offers{
            return 2
        }
        else{
             return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.viewDidLoad()
        let alert = UIAlertController(title: "Done", message: "your new item displayed", preferredStyle: UIAlertController.Style.actionSheet)
        
        self.present(alert, animated: true, completion: nil)
    let when = DispatchTime.now() + 2
    DispatchQueue.main.asyncAfter(deadline: when){
      // your code with delay
      alert.dismiss(animated: true, completion: nil)
    }
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
       
            
        if collectionView == SliderHome
        {
            let colWidth=SliderHome.frame.width
            
            let itemwidth=(colWidth)
            return CGSize(width: itemwidth, height:self.SliderHome.frame.size.height)
        }
      
        else
        {
            let colWidth=130
            
            let itemwidth=(colWidth)
            return CGSize(width:itemwidth,height:160)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == Offers
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "related", for: indexPath)
            
            return cell;
        }
        
        if collectionView == SliderHome
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderPrdDetails", for: indexPath)
            return cell;
        }
            
        else if collectionView == Products
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExtraProducts", for: indexPath) as? ExtraProductsCollectionViewCell
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnrelatedProducts", for: indexPath) as? UnrelatedProductsCollectionViewCell
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
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func butonzoom(_ sender: Any) {
        self.performSegue(withIdentifier: "zoom", sender: nil)
        
    }
    @IBOutlet weak var amount: UILabel!
    override func viewDidLayoutSubviews()
    {
        self.AddToCar.clipsToBounds = true
        let path = UIBezierPath(roundedRect: AddToCar.bounds,byRoundingCorners: [.topRight, .topLeft,.bottomLeft,.bottomRight],cornerRadii: CGSize(width: 20, height: 20))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        AddToCar.layer.mask = maskLayer
    }
    @IBAction func add(_ sender: Any) {
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
    
    
        
       
        
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
        
    
    }
    var extra = 0
    var idofpro = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
       // corner(img: colorcharacter, x: 7)
        providerpic.setImage(UIImage(named: "pro"), for: .normal)
        providerpic.layer.cornerRadius = 50
        providerpic.clipsToBounds = true
        
       amount.layer.cornerRadius = 20
        amount.clipsToBounds = true
       // print(upcomingitem[0].price,"DONE")
        
    }
    
     var  x = 1
    @IBAction func minase(_ sender: Any) {
        if x >= 1{
        x-=1
        amount.text = String(x)
        }
        }
    @IBAction func pluss(_ sender: Any) {
       
        x += 1
        amount.text = String(x)
    }
    
    func corner(img : UIImageView, x : Float) {
        img.layer.cornerRadius = CGFloat(x)
    }
   
   
}




