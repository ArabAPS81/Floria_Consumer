//
//  splashViewController.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit
import Network

class splashViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    var animationTimer :Timer!
    @IBOutlet var GetStartedButton: UIButton!
    // var arrOfImages:[UIImage]!
     @IBOutlet var CollectionViewOfPage: UICollectionView!
     var indexpath:Int=0
     @IBOutlet var CollectionViewOfSides: UICollectionView!
     @IBOutlet var Desc: UILabel!
     @IBOutlet var Extra_products: UILabel!
    var arrOfimages : Array<UIImage> = [UIImage(named: "Image-1.png")!,UIImage(named: "Image-1.png")!]
   var  arroftext = ["A Flower , sometimes known as bloom or blossom, is the reproductive structer found in flowering plants ","A Flower , sometimes known as bloom or blossom"]
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            if collectionView==CollectionViewOfSides
            {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlidesCell", for: indexPath)
                return cell
            }
            else
            {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageController", for: indexPath)
               
               
            
                return cell;

            }
            
    }
    override func viewDidLoad() {
        GetStartedButton.layer.cornerRadius = 20
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                
            } else {
                print("No connection.")
                self.customalert(header: "Alert", body: "your internet connections dont successfully ")
            
            }

            print(path.isExpensive)
        }
    }

    @IBAction func StartedButton(_ sender: Any)
    {
        
        if UserDefaults.standard.string(forKey: "userid") == nil {
            self.performSegue(withIdentifier: "nothere", sender: nil)
            
        }else {
            self.performSegue(withIdentifier: "there", sender: nil)
        }
    animationTimer.invalidate()
    }
       override func viewDidAppear(_ animated: Bool)
          {
               animationTimer = Timer.scheduledTimer(timeInterval:3.5, target: self, selector: #selector(updateImage), userInfo: nil, repeats: true)
            
          }
         
          @objc func updateImage()
          {
          if indexpath < arrOfimages.count-1
          {
          indexpath=indexpath+1
          Extra_products.text = "Extra"
          Desc.text = arroftext[indexpath]
          CollectionViewOfPage.reloadData()
              
          }
          else
          {
          indexpath=0
            Extra_products.text = "Extra"
          Desc.text = arroftext[indexpath]
          CollectionViewOfPage.reloadData()

          }
      CollectionViewOfSides.scrollToItem(at:IndexPath(item:indexpath, section: 0), at: .centeredHorizontally, animated: false)
      CollectionViewOfPage.scrollToItem(at:IndexPath(item:indexpath, section: 0), at: .centeredHorizontally, animated: false)

          }
    
    func customalert(header:String , body : String){
        let alert = UIAlertController(title: header, message: body , preferredStyle: UIAlertController.Style.actionSheet)
                        
                        self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                      // your code with delay
                      alert.dismiss(animated: true, completion: nil)
                    }
    }
}
