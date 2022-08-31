//
//  ViewController.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var label: UILabel!
    
    var list: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottoAPIManger.requestLotto(drwNo: 111) { lotto, error in
            
            guard let lotto = lotto else { return }
            self.label.text = lotto.drwNoDate
            
        }
        
        PersonAPIManger.requestLotto(query: "Kim"){ person, error in
            
            guard let person = person else { return }
            dump(person)
            self.list = person
            self.tableView.reloadData()
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = list?.results[indexPath.row].name
        return cell
    }
}
