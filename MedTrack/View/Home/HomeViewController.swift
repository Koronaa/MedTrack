//
//  ViewController.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var currentScoreStackView: UIStackView!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var recentHistoryTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    private let homeVM = HomeViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupSubscriptions()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        homeVM.getCurrentRecord()
        getRecentReports()
    }
    
    
    
    private func getRecentReports(){
        UIHelper.show(view: activityIndicator)
        noDataLabel.text = "Retrieving Recents Records..."
        UIHelper.show(view: noDataLabel)
        homeVM.getRecentRecords {
            DispatchQueue.main.async {
                self.recentHistoryTableView.reloadData()
                self.updateTableViewUI(for: self.homeVM.totalRecordsCount)
            }
        }
    }
    
    private func setupTableView(){
        recentHistoryTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue)
        recentHistoryTableView.delegate = self
        recentHistoryTableView.dataSource = self
    }
    
    private func setupUI(){
        self.view.backgroundColor = .BackgroundColor
        UIHelper.addCornerRadius(to: headerView,withRadius: 6.0)
        UIHelper.addShadow(to: headerView, with: 1.5, and: 0.2)
        UIHelper.addCornerRadius(to: currentScoreStackView, withRadius: 6.0)
        UIHelper.addCornerRadius(to: yesButton,withRadius: 6.0)
        recentHistoryTableView.backgroundColor = .BackgroundColor
        greetingLabel.text = homeVM.getGreetingText()
        
    }
    
    @objc private func willEnterForeground(){
        homeVM.getCurrentRecord()
        getRecentReports()
        setupUI()
    }
    
    private func setupScoreUI(for score:Int){
        self.currentScoreLabel.text = score.description
        UIHelper.hide(view: yesButton)
        if score == 100{
            updateQuestionLabel(with: "You've taken all the medicine for the day 👏🏻")
        }else {
            let isDataAdded = homeVM.getDataAvailability(for: Date())
            if isDataAdded{
                UIHelper.hide(view: yesButton)
                updateQuestionLabel(with: "You're all set for now")
                
                if homeVM.hasTakenNightMed ?? false{
                    updateQuestionLabel(with: "You're done for the day 🥱")
                }
            }else{
                resetHeaderUI()
            }
        }
    }
    
    private func resetHeaderUI(){
        UIHelper.show(view: yesButton)
        questionLabel.textAlignment = .left
        questionLabel.text = "Did you take your medicine?"
    }
    
    private func updateQuestionLabel(with text:String){
        questionLabel.text = text
        questionLabel.textAlignment = .center
    }
    
    private func setupSubscriptions(){
        homeVM.score.subscribe (onNext:{ score in
            DispatchQueue.main.async {
                self.setupScoreUI(for: score)
            }
        }).disposed(by: bag)
        
        
        homeVM.errorMessage.subscribe(onNext:{ message in
            UIHelper.showUserMessage(for: message)
        }).disposed(by: bag)
        
        homeVM.successMessage.subscribe(onNext:{ message in
            UIHelper.showUserMessage(for: message,type: .Success)
        }).disposed(by: bag)
        
        homeVM.dataUpdated.subscribe { [weak self] _ in
            self?.getRecentReports()
            self?.updateTableViewUI(for: self?.homeVM.totalRecordsCount ?? 0)
        }.disposed(by: bag)
    }
    
    private func updateTableViewUI(for itemCount:Int){
        UIHelper.hide(view: activityIndicator)
        if itemCount == 0{
            noDataLabel.text = "No Recent Records Found."
            UIHelper.show(view: noDataLabel)
        }else{
            UIHelper.show(view: recentHistoryTableView)
            UIHelper.hide(view: noDataLabel)
        }
    }
    
    @IBAction func yesButtonOnTapped(_ sender: Any) {
        homeVM.addRecord()
    }
    
    @objc func seeMoreButtonTapped(){
        let historyVC = UIHelper.makeViewController(viewControllerName: .HistoryViewColntroller) as! HistoryViewController
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.totalRecordsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue) as! HistoryTableViewCell
        let cellVM = HistoryTableViewCellViewModel(record: homeVM.recentRecords[indexPath.row])
        cell.historyTVCViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Records"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 15, y: 1, width: 320, height: 20)
        myLabel.font = UIFont(name: "Avenir-Heavy", size: 16)
        myLabel.textColor = .darkGray
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let seeMoreButton = UIButton()
        seeMoreButton.setTitle("See more", for: .normal)
        seeMoreButton.tag = section
        seeMoreButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 15)
        seeMoreButton.setTitleColor(.lightGray, for: .normal)
        
        seeMoreButton.frame = CGRect(x: self.view.frame.width - 110, y: 1, width: 120, height: 20)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 253/255, alpha: 1.0)
        headerView.addSubview(myLabel)
        headerView.addSubview(seeMoreButton)
        
        if homeVM.totalRecordsCount < AppConstants.RECENT_DATA_COUNT {
            UIHelper.hide(view: seeMoreButton)
        }else{
            UIHelper.show(view: seeMoreButton)
        }
        
        return headerView
    }
    
}

