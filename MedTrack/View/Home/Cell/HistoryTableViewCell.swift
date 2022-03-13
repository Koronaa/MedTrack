//
//  HistoryTableViewCell.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-12.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var morningTimeLabel: UILabel!
    @IBOutlet weak var eveningTimeLabel: UILabel!
    @IBOutlet weak var noMedicineTakenLabel: UILabel!
    @IBOutlet weak var nightTimeLabel: UILabel!
    
    
    var historyTVCViewModel: HistoryTableViewCellViewModel!{
        didSet{
            setupCellUI()
            setupCell(for: historyTVCViewModel)
        }
    }
    
    private func setupCellUI(){
        containerView.backgroundColor = .MedTrackYellow
        UIHelper.addCornerRadius(to: containerView)
        UIHelper.addShadow(to: containerView, with: 1.5,and: 0.2)
        UIHelper.addCornerRadius(to: morningTimeLabel)
        UIHelper.addCornerRadius(to: eveningTimeLabel)
        UIHelper.addCornerRadius(to: nightTimeLabel)
    }
    
    
    private func setupCell(for cellVM:HistoryTableViewCellViewModel){
        scoreLabel.text = cellVM.score.description
        dateLabel.text = cellVM.descriptiveDateString
        if cellVM.score == 0{
            UIHelper.hide(view: timeStackView)
            UIHelper.show(view: noMedicineTakenLabel)
        }else{
            cellVM.isNightMedTaken ? UIHelper.show(view: nightTimeLabel) : UIHelper.hide(view: nightTimeLabel)
            cellVM.isEveningMedTaken ? UIHelper.show(view: eveningTimeLabel) : UIHelper.hide(view: eveningTimeLabel)
            cellVM.isMorningMedTaken ? UIHelper.show(view: morningTimeLabel) : UIHelper.hide(view: morningTimeLabel)
            
            UIHelper.show(view: timeStackView)
            UIHelper.hide(view: noMedicineTakenLabel)
        }
    }
    
}
