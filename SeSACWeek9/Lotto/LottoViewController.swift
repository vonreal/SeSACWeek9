//
//  LottoViewController.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/09/01.
//

import UIKit

class LottoViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
            self.bindData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.viewModel.fetchLottoAPI(drwNo: 1022)
            self.bindData()
        }
        
        bindData()
    }
    
    func bindData() {
        viewModel.number1.bind { number in
            self.label1.text = "\(number)"
        }
        viewModel.number2.bind { number in
            self.label2.text = "\(number)"
        }
        viewModel.number3.bind { number in
            self.label3.text = "\(number)"
        }
        viewModel.number4.bind { number in
            self.label4.text = "\(number)"
        }
        viewModel.number5.bind { number in
            self.label5.text = "\(number)"
        }
        viewModel.number6.bind { number in
            self.label6.text = "\(number)"
        }
        viewModel.number7.bind { number in
            self.label7.text = "\(number)"
        }
        viewModel.lottoMoney.bind { number in
            self.dateLabel.text = number
        }
    }
}
