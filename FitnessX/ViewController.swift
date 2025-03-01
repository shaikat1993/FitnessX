//
//  ViewController.swift
//  FitnessX
//
//  Created by Md Sadidur Rahman on 5/1/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        printLoadedFonts()
    }
    
    private func printLoadedFonts() {
        for family in UIFont.familyNames.sorted() {
            print("Family: \(family)")
            for font in UIFont.fontNames(forFamilyName: family).sorted() {
                print("- \(font)")
            }
        }
    }


}

