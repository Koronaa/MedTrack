//
//  UIHelper.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import Foundation
import UIKit

class UIHelper{
    
    
    static private func makeViewController(storyBoardName:String, viewControllerName:String) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerName)
    }
    
    static func makeViewController<T:UIViewController>(in storyboard:UIConstant.StoryBoardName = .Main,viewControllerName:UIConstant.StoryBoardID) -> T{
        return makeViewController(storyBoardName: storyboard.rawValue, viewControllerName: viewControllerName.rawValue) as! T
    }
    
    static func addShadow(to view:UIView, with shadowRadius:CGFloat = 3.0, and opacity:Float = 0.4){
        view.layer.masksToBounds = false
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: -1.0, height: -1.0)
        view.layer.shadowOpacity = opacity
    }
    
    static func addCornerRadius(to view:UIView,withRadius radius:CGFloat = 4, withborder:Bool = false,using borderColor:UIColor = UIColor.black){
        view.layer.cornerRadius = radius
        if (withborder){
            view.layer.borderWidth = 0.5
            view.layer.borderColor = borderColor.cgColor
        }
        view.layer.masksToBounds = true
    }
    
    static func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    static func refreshView(view:UIView){
        UIView.animate(withDuration: 0.3) {
            view.layoutIfNeeded()
        }
    }
    
    static func enableView(view:UIView){
        DispatchQueue.main.async {
            view.isUserInteractionEnabled = true
            view.alpha = 1.0
        }
    }
    
    static func hideView(view:UIView){
        view.isHidden = true
    }
    
    static func showView(view:UIView){
        view.isHidden = false
    }
    
    static func hide(view:UIView){
        DispatchQueue.main.async {
            view.isHidden = true
        }
    }
    
    static func show(view:UIView){
        DispatchQueue.main.async {
            view.isHidden = false
        }
    }
    
    
    
}
