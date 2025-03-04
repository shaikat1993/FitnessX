//
//  WelcomeVC.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 7/1/25.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var getStartedBtnOutlet: UIButton!
    
    private var viewModel: WelcomeViewModel?

    
    func configure(with viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedBtnOutlet.applyGradient(hexColors: ["#96B3FE",
                                                      "#97B7FE"])
    }
    
    @IBAction func getStartedTapped(_ sender: UIButton) {
        viewModel?.getStartedTapped()
    }
}
