//
//  OnboardingCVCell.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 5/1/25.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell {
    static let identifier = "OnboardingCVCell"

    @IBOutlet weak var ivOutlet: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with slide: OnboardingSlideModel) {
        ivOutlet.image          = slide.image
        titleLabel.text         = slide.title
        descriptionLabel.text   = slide.description
    }
}
