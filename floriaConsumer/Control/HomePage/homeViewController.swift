//
//  homeViewController.swift
//  Alamofire
//
//  Created by macbookpro on 7/15/19.
//

import UIKit
import SideMenu
import Alamofire
import FirebaseMessaging

protocol HomeView: class{
    func didReceiveData(data: Codable)
    func didFailToReceiveData(error: Error)
}


class HomeViewController: UIViewController {
    
    var presenter: HomePresenter!
    var vendorsList = [VendorsModel.Vendor]()
    var productsList = [ProductsModel.Product]()
    var slidersList = [HomeSliderModel.Slider]()
    
    
    @IBOutlet var homeButtonsCollction: [UIButton]!
    @IBOutlet var search: UIBarButtonItem!
    @IBOutlet var sideMenu: UIBarButtonItem!
    
    @IBOutlet var Offers: UICollectionView!
    @IBOutlet var Products: UICollectionView!
    @IBOutlet var SliderHome: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        registerCells()
        setupViews()
        setupSideMenu()
        presenter = HomePresenter.init(view: self)
        Messaging.messaging().subscribe(toTopic: "general") { error in
          print("Subscribed to general topic")
        }
        Messaging.messaging().subscribe(toTopic: "consumer") { error in
          print("Subscribed to consumer topic")
        }
        
    }
    
    
    private func setupSideMenu() {
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
        super.viewWillAppear(animated)
        Products.reloadData()
        presenter.getNearestVendor()
        Offers.startLoading()
        presenter.getFeaturedProducts()
        Products.startLoading()
        presenter.getHomeSliderData()
        SliderHome.startLoading()
    }
    
    func registerCells() {
        let nib = UINib.init(nibName: "HomeProductCollectionViewCell", bundle: nil)
        Products.register(nib, forCellWithReuseIdentifier: "HomeProductCollectionViewCell")
        
        let nib2 = UINib.init(nibName: "HomeVendorCollectionViewCell", bundle: nil)
        Offers.register(nib2, forCellWithReuseIdentifier: "HomeVendorCollectionViewCell")
    }
    
    @IBAction func gerbButtonTapped(_ sender: UIButton) {
        let vc = VendorsListViewController.newInstance(service: .gerb)
        orderRequest = SubmittOrderQueryModel.init()
        orderRequest.serviceId = 3
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func customBouquetButtonTapped(_ sender: UIButton) {
        let vc = VendorsListViewController.newInstance(service: .customBouquet)
        orderRequest = SubmittOrderQueryModel.init()
        orderRequest.serviceId = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func readyMadeButtonTapped(_ sender: UIButton) {
        let vc = VendorsListViewController.newInstance(service: .readyMade)
        orderRequest = SubmittOrderQueryModel.init()
        orderRequest.serviceId = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func carDecorationButtonTapped(_ sender: UIButton) {
        let vc = AddressesListViewController.newInstance(serviceType: .carDecoration)
        orderRequest = SubmittOrderQueryModel.init()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func potsCareButtonTapped(_ sender: UIButton) {
        let vc = PotsCareViewController.newInstance()
        orderRequest = SubmittOrderQueryModel.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "SideMenu", bundle: nil)
        let menu = storyboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! SideMenuNavigationController
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = UIScreen.main.bounds.size.width * 0.8
        menu.statusBarEndAlpha = 0
        menu.animationOptions = .allowUserInteraction
        menu.leftSide = !Defaults().isArabic
        present(menu, animated: true, completion: nil)
    }
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case Offers:
            return vendorsList.count
            case Products:
                return productsList.count
            case SliderHome:
                return slidersList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == SliderHome {
            let colWidth=SliderHome.bounds.width
            let itemwidth=(colWidth)
            return CGSize(width: itemwidth, height:self.SliderHome.bounds.size.height)
        }else if collectionView != Products {
            return CGSize(width:150,height:190)
        }else {
            return CGSize(width:150,height:190)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == SliderHome {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderHome", for: indexPath) as! SliderHomeCollectionViewCell
            cell.configure(url: slidersList[indexPath.row].image ?? "")
            return cell;
        } else if collectionView == Products {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionViewCell", for: indexPath) as! HomeProductCollectionViewCell
            cell.cofigure(product: productsList[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVendorCollectionViewCell", for: indexPath) as! HomeVendorCollectionViewCell
            cell.cofigure(vendor: vendorsList[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == SliderHome {
            let model = slidersList[indexPath.row]
            if model.modelType == "provider"{
                let vc = VendorDetailsViewController.newInstance(vendorId: model.modelId ?? 0)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if collectionView == Products {
            let vc = ProductDetailsViewController.newInstance(product: productsList[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == Offers {
            let vendor = vendorsList[indexPath.row]
            
            let vc = VendorDetailsViewController.newInstance(vendorId: vendor.id ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomeViewController: HomeView {
    func didReceiveData(data: Codable) {
        if let data = data as? VendorsModel {
            vendorsList = data.vendors ?? []
            Offers.reloadData()
            Offers.stopLoading()
        }
        if let data = data as? ProductsModel {
            productsList = data.products ?? []
            Products.reloadData()
            Products.stopLoading()
        }
        if let data = data as? HomeSliderModel {
            slidersList = data.sliders ?? []
            SliderHome.reloadData()
            SliderHome.stopLoading()
        }
    }
    
    func didFailToReceiveData(error: Error) {
        Offers.stopLoading()
        Products.stopLoading()
        SliderHome.stopLoading()
    }
    
    
}

