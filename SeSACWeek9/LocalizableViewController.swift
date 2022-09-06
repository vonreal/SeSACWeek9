//
//  LocalizableViewController.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/09/06.
//

import UIKit
import CoreLocation

class LocalizableViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "navigation_title".localized
        
        myLabel.text = "introduce".localized(with: "고래밥")
//        myLabel.text = String(format: "number_test".localized, "23")
        
        inputTextField.text = "number_test".localized(number: 22)
        
        searchBar.placeholder = "search_placeholder".localized
        inputTextField.placeholder = "main_age_placeholder".localized
        
        let buttonTitle = "common_cancel".localized
        sampleButton.setTitle(buttonTitle, for: .normal)
        
//        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    
    @IBAction func sampleButtonClicked(_ sender: UIButton) {
        
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(number: Int) -> String {
        return String(format: self.localized, number)
    }
}
