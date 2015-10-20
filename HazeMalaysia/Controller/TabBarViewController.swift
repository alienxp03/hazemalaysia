//
//  TabBarViewController.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 17/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        delegate = self
        tabBar.translucent = false
    }
}

extension TabBarViewController : UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        guard let controllerIndex = viewControllers?.indexOf(viewController) else { return false }

        let fromView = tabBarController.selectedViewController?.view
        let toView = tabBarController.viewControllers?[controllerIndex].view

        UIView.transitionFromView(fromView!, toView: toView!, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, completion: nil)
        return true
    }
    
    func tabBarController2(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        guard let controllerIndex = viewControllers?.indexOf(viewController) else { return false }
        
        if controllerIndex == tabBarController.selectedIndex {
            return false
        }
        
        let fromView = tabBarController.selectedViewController?.view
        let toView = tabBarController.viewControllers?[controllerIndex].view
        
        let viewSize = fromView?.frame
        let scrollRight = controllerIndex > tabBarController.selectedIndex

        fromView?.superview?.addSubview(toView!)
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        toView?.frame = CGRect(x: (scrollRight ? screenWidth : -screenWidth), y: (viewSize?.origin.y)!, width: screenWidth, height: (viewSize?.size.height)!)
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            fromView?.frame = CGRect(x: (scrollRight ? -screenWidth : screenWidth), y: viewSize!.origin.y, width: screenWidth, height: viewSize!.size.height)
            toView?.frame = CGRect(x: 0, y: viewSize!.origin.y, width: screenWidth, height: viewSize!.size.height)
            
            }, completion: {
                finished in
                if finished {
                    fromView?.removeFromSuperview()
                    tabBarController.selectedIndex = controllerIndex
                }
        })
        
        return false
    }
}