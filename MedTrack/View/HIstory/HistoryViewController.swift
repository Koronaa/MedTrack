//
//  HistoryViewController.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        
    }
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: backButton)
    }
    
    private func setupTableView(){
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: .main), forCellReuseIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue)
        historyTableView.delegate = self
        historyTableView.dataSource = self
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
        return 17
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstant.Cell.HistoryTableViewCell.rawValue) as! HistoryTableViewCell
        cell.setupCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
    
}
