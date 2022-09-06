//
//  LocalizableViewController.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/09/06.
//

import UIKit
import CoreLocation
import MessageUI //메일로 보내기, 디바이스 테스트, 아이폰 메일 계정을 등록 해야 가능

class LocalizableViewController: UIViewController, MFMailComposeViewControllerDelegate {

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
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["rhrheld@gmail.com"])
            mail.setSubject("고래밥 다이어리 문의사항 ~")
            mail.mailComposeDelegate = self // 메일을 보냈는지 보내다 실패했는지 확인해 볼 수 있다.
            self.present(mail, animated: true)
        } else {
            // alert. 메일 등록을 해주시거나, sesac@sesac.com으로 문의 주세요.
            print("alert")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print(#function)
    }
    
    @IBAction func sampleButtonClicked(_ sender: UIButton) {
        sendMail()
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
