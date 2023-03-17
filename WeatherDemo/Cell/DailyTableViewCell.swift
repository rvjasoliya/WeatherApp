//
//  DailyTableViewCell.swift
//  WeatherDemo
//
//  Created by iMac on 17/03/23.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewWithShadow: UIView!
    
    static let xibName = "DailyTableViewCell"
    static let cellIdentifier = "DailyTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.initialConfig()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Initial Config
    func initialConfig() {
        self.selectionStyle = .none
        self.setCornerRadiusWithShadow()
    }
    
    // Set Corner Radius & Shadow
    func setCornerRadiusWithShadow() {
        self.viewWithShadow.addShadowToView(shadow_color: UIColor(white: 0.0, alpha: 1.0), offset: CGSize(width: 1, height: 1), shadow_radius: 3, shadow_opacity: 0.2, corner_radius: 8.0, isOnlyBottomShadow: false)
    }
    
}
