//
//  HistoryViewController.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import UIKit
import RxSwift

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    private let historyVM = HistoryViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setSubsribers()
        getAllRecords()
        
    }
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: backButton)
        historyTableView.backgroundColor = .BackgroundColor
    }
    
    private func getAllRecords(){
        UIHelper.show(view: activityIndicator)
        noDataLabel.text = "Retrieving Records..."
        UIHelper.show(view: noDataLabel)
        UIHelper.hide(view: historyTableView)
        historyVM.getAllRecords()
    }
    
    private func setupTableView(){
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue)
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    private func setSubsribers(){
        historyVM.records.subscribe ( onNext: { records in
            self.setTableViewUI(for: records?.count ?? 0)
            self.historyTableView.reloadData()
        }).disposed(by: bag)
        
        historyVM.error.subscribe (onNext:{ message in
            if let errorMessage = message{
                UIHelper.showUserMessage(for: errorMessage,type: .Warning)
            }
        }).disposed(by: bag)
        
    }
    
    private func setTableViewUI(for resultCount:Int){
        UIHelper.hide(view: activityIndicator)
        if resultCount == 0{
            UIHelper.hide(view: historyTableView)
            noDataLabel.text = "No Records Found"
            UIHelper.show(view: noDataLabel)
        }else{
            UIHelper.show(view: historyTableView)
            UIHelper.hide(view: noDataLabel)
        }
    }
    
    
    
    @IBAction func backButtonOnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension HistoryViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyVM.records.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue) as! HistoryTableViewCell
        if let record = historyVM.records.value?[indexPath.row]{
            cell.historyTVCViewModel = HistoryTableViewCellViewModel(record: record)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    
}
