//
//  ContainerViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
enum MenuItemVCType:Int{
    case Home,Profile,Settings
}
class ContainerViewController: UIViewController {
    
    var isOpened = false
    var menuViewController:UIViewController!
    var currentViewController:UIViewController!
    var firstLoad = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeViewController(itemType: 0) //Home
    }
    
    func configureHomeViewController(itemType:MenuItemVCType.RawValue){
        switch itemType {
        case 0 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
            vc?.delegate = self
            self.currentViewController = vc!
        default:
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddVenueVC") as? AddVenueController
            vc?.delegate = self
            vc?.menuDelegate = self
            self.currentViewController = vc!
        }
        self.isOpened = false
        addChild(currentViewController)
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
        setCustomHeader()
    }
    
    func configureMenuViewController(){
        clearHeader()
        self.menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as? MenuViewController
        (menuViewController as? MenuViewController)?.menuDelegate = self
        addChild(menuViewController)
        view.insertSubview(menuViewController.view, at: 0)
        menuViewController.didMove(toParent: self)
    }
    func showMenuVC(_ shouldOpen:Bool){
        if !shouldOpen{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.currentViewController.view.frame.origin.x = self.currentViewController.view.frame.width - 120
                
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.currentViewController.view.frame.origin.x = 0
                self.setCustomHeader()
            }, completion: nil)
        }
    }
    
}
extension ContainerViewController:HamburgerMenuDelegate{
    func didTapButton() {
        if !isOpened{
            configureMenuViewController()
        }else{
            setCustomHeader()
        }
        showMenuVC(isOpened)
        isOpened = !isOpened
    }
    
    
}
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

extension ContainerViewController{
    func setCustomHeader(){
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.6773885489, green: 0.3582394719, blue: 0.3431926668, alpha: 1)
        self.firstLoad = true
        setNeedsStatusBarAppearanceUpdate()
    }
    func clearHeader(){
        //UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if isOpened || firstLoad{
            firstLoad = false
            return .lightContent
        }else {
            return .default
        }
    }
}

extension ContainerViewController:MenuSelectDelegate{
    func didClickedItem(_ index: Int) {
        print(index)
        showMenuVC(true)
        isOpened = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.15) {
            self.currentViewController.remove()
            self.configureHomeViewController(itemType: index)
        }
    }
}
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
