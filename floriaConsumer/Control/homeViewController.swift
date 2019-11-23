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



class homeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    var populeritem = [populer]()
    var upcomingitem = [populer]()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if collectionView == Products
                  {
//self.performSegue(withIdentifier: "proudct", sender: nil)
       }else{
        //
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var x = 5
      
//                        if collectionView == Products
//            {
//               return  populeritem.count
//
//            }
//            if collectionView == Offers
//            {
//                return  upcomingitem.count
//
//            }
//            if collectionView == SliderHome
//            {
//                //return  arrOfServiceImages.count
//
//            }
            
            return x
            
        
      
        
        
        
    }
    
    @IBAction func readymade(_ sender: Any) {
        self.performSegue(withIdentifier: "listvendor", sender: nil)
    }
    @IBAction func gerb(_ sender: Any) {
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

     
//
//              cell?.price.text = String(populeritem[indexPath.row].price)
//              cell?.numberofrate.text = String(populeritem[indexPath.row].ratee) + "⭐️"
//              cell?.name.text = String(populeritem[indexPath.row].titel)
//              let xx = NSURL(string: "http://api.floriaapp.com/" + populeritem[indexPath.row].img)
//              //print(xx["img_path"],"8888888888888887777777")
//              cell?.image.kf.setImage(with: xx as! URL)
//          cell?.viewOfProductsImags.clipsToBounds = true
            
          
              
              maskLayer.path = path.cgPath
          cell?.viewOfProductsImags.layer.mask = maskLayer
              
          
              
              
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

    override func viewWillAppear(_ animated: Bool)
    {
        
        
        Products.reloadData()
        
     


    }
override func viewDidLoad()
{
    
//recevpopuler(collecyio: Products, modelarray: 1, ext: "PopularProduct")
  //  recevpopuler(collecyio: Offers, modelarray: 2, ext: "NewestProviders")
super.viewDidLoad()
   
    readymade.layer.cornerRadius = 23
    assemd.layer.cornerRadius = 23
    home.layer.cornerRadius = 23
    car.layer.cornerRadius = 23
    gerb.layer.cornerRadius = 23
}
  

    
    
    
    func recevpopuler( collecyio : UICollectionView ,modelarray : Int , ext : String )  {
       
      let url = "http://api2.floriaapp.com/api/" + ext
        let header = [
            "Accept" : "application/json",
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization": "Bearer "+"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImU1MTNmZDNmMjYxNThhN2Q1YzZlNzViYzM3MTk1NTEyZGRlMWIyMDIzYzIzMDAyMTRjMDIwYmI4ZTcxODM1YTQ0NDQyZTJkZTcwODc3YTI2In0.eyJhdWQiOiIxIiwianRpIjoiZTUxM2ZkM2YyNjE1OGE3ZDVjNmU3NWJjMzcxOTU1MTJkZGUxYjIwMjNjMjMwMDIxNGMwMjBiYjhlNzE4MzVhNDQ0NDJlMmRlNzA4NzdhMjYiLCJpYXQiOjE1NzM5MjUzMDEsIm5iZiI6MTU3MzkyNTMwMSwiZXhwIjoxNjA1NTQ3NzAxLCJzdWIiOiI3Iiwic2NvcGVzIjpbXX0.mTwnhov6Vhmt9Pktvno63ArQY8gucHeFYzrbaAe7yhunDPtb488MD9t0977KIixDeFSbMeZmn2s6-a5gtV9lecY8-y3NhbHmovBeSHlCEl1Siaf0uH_ZtXZGb9F1VvuK3RVWhj1iQH91ZVuTohpf6hIvo2cq08yTtZBx4SfbCgK5Zq9ZCVvnNdNXnBbHyl3J8HduMDd-V-N6cBBuHfAO4nN0hgEkd023kp_VG_VTsQHZa36b3bxhe24JrFDvxh8hXn3Bc9TUx4Dgannu99uoMa0M-sr4Y2Xs1hm3x3AskbuRsICARiVMIBXI7j2871Fi1Bt7VN7nHJV9QfZdnzYM6fFN07w8hFSF6nhu2qU4PpvPm9cfvpctn6ztjNtslCS--A_te_FEqjXiQfLLmoLrjPv5xtoN7xhVmDxV0JR1LXsXRtVyFUy0OjlJjfnnnyJVL3lCbX50lK-Zlla6Xr03pUX2MAi47VngIvAFZfe0Ebqt06qQ7wCUXjkMoKn5iAGvv6m_vFS2lduEoQXiO7m1AeRFJqn4Gg63n8S1434Bz1seq1dY8l4kkDL2yfoAbcdgTM89ilS896PlZU-crI-R_Po4TNRFwFTXk-DCKORgj5dvJfJGECHIIUtfz4QTP6gjXateYHB92sdQRDo1KxcmU3YE3cUpH6Sn9ZX6C2AsGL8"
        ]
       
        
        Alamofire.request(url,method: .post, parameters: nil, encoding: URLEncoding.default, headers: header).responseJSON { re in
            switch re.result
            {
            case .failure(let erro):
                print("********////",erro)
            case .success(let value):
                var jsoncode = JSON(value)
                print(jsoncode,"respnoonoononoon")
               
                 guard let data = jsoncode[].array else {return}
                 for ofeers in data{
              
                  if let dataa = ofeers.dictionary,let trip = populer.init(dict:dataa){
                    if modelarray == 1 {
                        self.populeritem.append(trip)
                  collecyio.reloadData()
                    }else{
                        self.upcomingitem.append(trip)
                        collecyio.reloadData()
                    }
                 //
                 
                 }
                 
                 }
                
            }
            
            
        }
    }
}

