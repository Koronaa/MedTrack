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
    @IBOutlet weak var noDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupTableView(){
        recentHistoryTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue)
        recentHistoryTableView.delegate = self
        recentHistoryTableView.dataSource = self
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
        //TODO:
    }
    
    @objc func seeMoreButtonTapped(){
        let historyVC = UIHelper.makeViewController(viewControllerName: .HistoryViewColntroller) as! HistoryViewController
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue) as! HistoryTableViewCell
        cell.setupCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Days"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 15, y: 1, width: 320, height: 20)
        myLabel.font = UIFont(name: "Avenir-Heavy", size: 16)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let seeMoreButton = UIButton()
        seeMoreButton.setTitle("See more", for: .normal)
        seeMoreButton.tag = section
        seeMoreButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)
        seeMoreButton.setTitleColor(.darkGray, for: .normal)
        
        seeMoreButton.frame = CGRect(x: self.view.frame.width - 110, y: 1, width: 120, height: 20)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 253/255, alpha: 1.0)
        headerView.addSubview(myLabel)
        headerView.addSubview(seeMoreButton)
        
        return headerView
    }
    
}

