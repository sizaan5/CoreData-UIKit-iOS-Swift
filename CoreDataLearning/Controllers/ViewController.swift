//
//  ViewController.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private var manager = EmployeeManager()
    private var employees: [Employee] = []

    //MARK: - view LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Employees"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path)
        self.setupTableView()
        
        let btnAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.addAction))
        let btnPassport = UIBarButtonItem(image: UIImage(systemName: "menucard"), style: .plain, target: self, action: #selector(self.passportAction))
        navigationItem.rightBarButtonItems = [btnAdd, btnPassport]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.employees = self.manager.getAllEmployee() ?? []
        
        self.tableView.reloadData()
    }
    
    //MARK: - Helper Methods
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
    }
    
    @objc func addAction() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditViewController") as? AddEditViewController {
            vc.isFromEdit = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func passportAction() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PassportViewController") as? PassportViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
            let obj = self.employees[indexPath.row]
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { action, view, complete in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditViewController") as? AddEditViewController {
                vc.isFromEdit = true
                vc.empId = obj.id
                self.navigationController?.pushViewController(vc, animated: true)
            }
            complete(true)
        }
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .blue
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, complete in
            if self.manager.deleteEmployee(byIdentifier: obj.id) {
                self.employees.removeAll(where: { ( $0.id == obj.id ) })
                self.tableView.reloadData()
            }
            complete(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.image?.withTintColor(.white)
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as? EmployeeTableViewCell {
            let obj = self.employees[indexPath.row]
            cell.imgProfilePic.image = UIImage(data: obj.profilePicture)
            cell.lblName.text = obj.name
            cell.lblEmail.text = obj.email
            return cell
        }
        return UITableViewCell()
    }
}
