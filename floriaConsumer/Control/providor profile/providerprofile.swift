//
//  providerprofile.swift
//  floriaConsumer
//
//  Created by mac on 11/10/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class providerprofile: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! ExtraProductsCollectionViewCell
        cell.viewOfProductsImags.layer.cornerRadius = 20
        cell.viewOfProductsImags.clipsToBounds = true
        cell.viewOfProductsImags.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           cell.viewOfProductsImags.layer.shadowOffset = .zero
        
           cell.viewOfProductsImags.layer.shadowOpacity = 1
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        corner(bu: five, by: 10)
        corner(bu: four, by: 10)
        corner(bu: three, by:10)
        corner(bu: two, by: 10)
        corner(bu: one, by: 10)
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var one: UIButton!
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "prouduct", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func corner(bu: UIButton , by : Float){
        bu.layer.cornerRadius = CGFloat(by)
    }
}
