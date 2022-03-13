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
    
    
    func setupCell(for score:Int){
        //TODO: Data bind
        setupUI(for: score)
    }
    
    
    private func setupUI(for score:Int){
        scoreLabel.text = score.description
        containerView.backgroundColor = .MedTrackYellow
        UIHelper.addCornerRadius(to: containerView)
        UIHelper.addShadow(to: containerView, with: 1.5,and: 0.2)
        UIHelper.addCornerRadius(to: morningTimeLabel)
        UIHelper.addCornerRadius(to: eveningTimeLabel)
        UIHelper.addCornerRadius(to: nightTimeLabel)
        
        if score == 0{
            UIHelper.hide(view: timeStackView)
            UIHelper.show(view: noMedicineTakenLabel)
        }else{
            UIHelper.show(view: timeStackView)
            UIHelper.hide(view: noMedicineTakenLabel)
        }

    }
}
