//
//  homeViewController.swift
//  Alamofire
//
//  Created by macbookpro on 7/15/19.
//

import UIKit
import SideMenu

import Foundation



class homeViewController: UIViewController {
    
    
    
    
    @IBOutlet var homeButtonsCollction: [UIButton]!
    
    

    @IBOutlet var search: UIBarButtonItem!
    @IBOutlet var sideMenu: UIBarButtonItem!
    
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
        registerCells()
        setupViews()
        setupSideMenu()
    }
    
    private func setupSideMenu() {
        
        SideMenuManager.default.menuPresentMode = .viewSlideOut
        SideMenuPresentationStyle.menuSlideIn.backgroundColor = .clear
        SideMenuPresentationStyle.menuDissolveIn.backgroundColor = .clear
        SideMenuPresentationStyle.viewSlideOutMenuIn.backgroundColor = .clear
    }
    
    func setupViews() {
        homeButtonsCollction.forEach { (button) in
            button.layer.cornerRadius = button.bounds.height / 2
        }
        (SliderHome.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 0
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
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
    
    
    @IBAction func showSideMenu(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "SideMenu", bundle: nil)
        let menu = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! SideMenuNavigationController
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = UIScreen.main.bounds.size.width * 0.8
        menu.statusBarEndAlpha = 0
        present(menu, animated: true, completion: nil)
    }
    @IBAction func gerb(_ sender: Any) {
        //self.performSegue(withIdentifier: "listvendor", sender: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == SliderHome
        {
            let colWidth=SliderHome.bounds.width
            
            let itemwidth=(colWidth)
            
            return CGSize(width: itemwidth, height:self.SliderHome.bounds.size.height)
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

