//
//  PassportViewController.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import UIKit

class PassportViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private var passports: [Passport] = []
    private let manager = PassportManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Passports"
        self.tableView.register(UINib(nibName: "PassportTableViewCell", bundle: nil), forCellReuseIdentifier: "PassportTableViewCell")
        
        self.passports = self.manager.getAllPassports() ?? []
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PassportViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

extension PassportViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.passports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "PassportTableViewCell", for: indexPath) as? PassportTableViewCell {
            let obj = self.passports[indexPath.row]
            cell.lblPassportId.text = "Passport ID: \(obj.passportId ?? "N/A")"
            cell.empName.text = "Name of Employee: \(obj.name ?? "N/A")"
            return cell
        }
        return UITableViewCell()
    }
}
