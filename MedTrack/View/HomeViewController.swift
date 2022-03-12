//
//  ViewController.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var currentScoreStackView: UIStackView!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var recentHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.view.backgroundColor = UIColor.BackgroundColor
        UIHelper.addCornerRadius(to: headerView,withRadius: 6.0)
        UIHelper.addShadow(to: headerView, with: 1.5, and: 0.2)
        UIHelper.addCornerRadius(to: currentScoreStackView, withRadius: 6.0)
        UIHelper.addCornerRadius(to: yesButton,withRadius: 6.0)
        recentHistoryTableView.backgroundColor = UIColor.BackgroundColor
        //TODO: set label to You have taken all the medicine for the day 👏🏻🥳! when the score hits 100
    }
    
    @IBAction func yesButtonOnTapped(_ sender: Any) {
    }
    
}

