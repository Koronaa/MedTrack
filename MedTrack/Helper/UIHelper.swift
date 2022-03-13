//
//  UIHelper.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import Foundation
import UIKit
import BRYXBanner

enum BannerType{
    case Error
    case Warning
    case Success
}

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
    
    static func refreshView(view:UIView){
        UIView.animate(withDuration: 0.3) {
            view.layoutIfNeeded()
        }
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
    
    private static func makeBanner(title:String,message:String,style:BannerType) -> Banner{
        var bannerBackground:UIColor!
        switch style {
        case .Error:
            bannerBackground = .MedTrackErrorRed
        case .Success:
            bannerBackground =  .MedTrackSuccessGreen
        case .Warning:
            bannerBackground =  .MedTrackWarningYellow
        }
        
        let banner = Banner(title: title, subtitle: message, backgroundColor: bannerBackground)
        banner.textColor = .black
        banner.titleLabel.font = UIFont(name: "Avenir-Heavy", size: 16)
        banner.detailLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        return banner
    }
    
    static func showUserMessage(for message:UserMessage,type:BannerType = .Error){
        DispatchQueue.main.async {
            let banner = makeBanner(title: message.title, message: message.message, style: type)
            banner.dismissesOnTap = true
            banner.show(duration: 2.0)
        }
    }
    
}
