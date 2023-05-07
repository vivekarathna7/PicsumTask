//
//  PicsListCell.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import UIKit
import SDWebImage

class PicsListCell: UITableViewCell {
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxBtn.setImage(UIImage(named: "outline_check_box_outline_blank_black_48pt"), for: .normal)
        checkBoxBtn.setImage(UIImage(named: "outline_check_box_black_48pt"), for: .selected)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPic(pic: Pics) {
        if let url = URL(string: pic.downloadUrl) {
            picImageView.sd_setImage(with: url, completed: nil)
        }
        titleLbl.text = pic.author
        descLbl.text = pic.url
    }
}
