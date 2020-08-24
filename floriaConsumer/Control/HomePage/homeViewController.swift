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
import MaterialShowcase
import FBSDKCoreKit

protocol HomeView: class{
    func didReceiveData(data: Codable)
    func didFailToReceiveData(error: Error)
}


class HomeViewController: UIViewController {
    
    var presenter: HomePresenter!
    var vendorsList = [VendorsModel.Vendor]()
    var productsList = [ProductsModel.Product]()
    var slidersList = [HomeSliderModel.Slider]()
    var showCaseSequence: MaterialShowcaseSequence!
    
    
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
    
    func posttoken() {
        let deviceId = NSUUID().uuidString
        let service = AuthenticationService.init(delegate: self.presenter)
        service.postDeviceToken(Messaging.messaging().fcmToken ?? "")
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setShowCases()
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
       // showCaseSequence.removeUserState(key: "for")
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
                let vc = VendorDetailsViewController.newInstance(vendorId: Int(model.modelId ?? 0) )
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

extension HomeViewController :MaterialShowcaseDelegate{
    func setShowCases() {
        DispatchQueue.main.async {
            self.showCaseSequence = MaterialShowcaseSequence()
            
            let showcase1 = MaterialShowcase()
            showcase1.setTargetView(view: self.homeButtonsCollction[1])
            showcase1.primaryText = "Ready Made Bouquet"
            showcase1.secondaryText = "Click here to show ready made bouquet vendors"
            showcase1.shouldSetTintColor = false // It should be set to false when button uses image.
            showcase1.backgroundPromptColor = UIColor.gray
            showcase1.skipText = "Skip"
            showcase1.skipTextColor = #colorLiteral(red: 0.9692807794, green: 0, blue: 0.4361249506, alpha: 1)
            showcase1.isSkipButtonVisible = true
            showcase1.skipButtonBackgroundColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1)
            showcase1.skipButtonBorderRadius = 5
            showcase1.skipTextSize = 23.0
            
            showcase1.isTapRecognizerForTargetView = false
            
            let showcase2 = MaterialShowcase()
            showcase2.setTargetView(view: self.homeButtonsCollction[0])
            showcase2.primaryText = "Custom Bouquet"
            showcase2.secondaryText = "Click here to collect custom bouquet flowers "
            showcase2.shouldSetTintColor = false // It should be set to false when button uses image.
            showcase2.backgroundPromptColor = UIColor.gray
            showcase2.isTapRecognizerForTargetView = false
            
            showcase2.skipTextColor = #colorLiteral(red: 0.9692807794, green: 0, blue: 0.4361249506, alpha: 1)
            showcase2.isSkipButtonVisible = true
            showcase2.skipButtonBackgroundColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1)
            showcase2.skipButtonBorderRadius = 5
            
            let showcase3 = MaterialShowcase()
            showcase3.setTargetView(view: self.homeButtonsCollction[2])
            showcase3.primaryText = "Gerb"
            showcase3.secondaryText = "Click here select a Gerb"
            showcase3.shouldSetTintColor = false // It should be set to false when button uses image.
            showcase3.backgroundPromptColor = UIColor.gray
            showcase3.isTapRecognizerForTargetView = false
            
            let showcase4 = MaterialShowcase()
            showcase4.setTargetView(view: self.homeButtonsCollction[3])
            showcase4.primaryText = "Car Decoration"
            showcase4.secondaryText = "Click here to decorate your car"
            showcase4.shouldSetTintColor = false // It should be set to false when button uses image.
            showcase4.backgroundPromptColor = UIColor.gray
            showcase4.isTapRecognizerForTargetView = false
            
            let showcase5 = MaterialShowcase()
            showcase5.setTargetView(view: self.homeButtonsCollction[4])
            showcase5.primaryText = "Pots Care"
            showcase5.secondaryText = "Click here to demand pots care service"
            showcase5.shouldSetTintColor = false // It should be set to false when button uses image.
            showcase5.backgroundPromptColor = UIColor.gray
            showcase5.isTapRecognizerForTargetView = false
            
            
            showcase1.delegate = self
            showcase2.delegate = self
            showcase3.delegate = self
            showcase4.delegate = self
            showcase5.delegate = self
            
            
            self.showCaseSequence.temp(showcase1).temp(showcase2).temp(showcase3).temp(showcase4).temp(showcase5)
            if let tutorialOff = UserDefaults.standard.bool(forKey: "ShowCasesOff") as? Bool, !tutorialOff{
                self.showCaseSequence.setKey(key: "ShowCasesKey")
            }
            self.showCaseSequence.start()
        }
        
        
    }
    
    func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        showCaseSequence.showCaseWillDismis()
    }
    
    func showCaseSkipped(showcase: MaterialShowcase) {
        showCaseSequence.showcaseArray.removeAll()
        showcase.completeShowcase()
        
     
        
        
    }
    
}

