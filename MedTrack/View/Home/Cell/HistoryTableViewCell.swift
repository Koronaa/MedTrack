//
//  HistoryTableViewCell.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var morningTimeLabel: UILabel!
    @IBOutlet weak var eveningTimeLabel: UILabel!
    @IBOutlet weak var noMedicineTakenLabel: UILabel!
    @IBOutlet weak var nightTimeLabel: UILabel!
    
    
    func setupCell(){
        //TODO: Data bind
        setupUI()
    }
    
    
    private func setupUI(){
        UIHelper.addCornerRadius(to: containerView)
        UIHelper.addShadow(to: containerView)
        UIHelper.addCornerRadius(to: morningTimeLabel)
        UIHelper.addCornerRadius(to: eveningTimeLabel)
        UIHelper.addCornerRadius(to: nightTimeLabel)
    }
}
