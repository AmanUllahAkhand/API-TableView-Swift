//
//  ViewController.swift
//  GetApiTableView
//
//  Created by USER on 10/02/2022.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let customerRepository = CustomerRepository()
    
    private var myData : [Users]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        setupContainer()
        loadMyData()
    }

//For (+) Btn  (For POST Method)
    @IBAction func addNewListBtn(_ sender: Any) {
        
        let alertController = UIAlertController(title: "New Mamber List", message: "Give Your Information", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Your Name..."
         }
        alertController.addTextField { (textField) in
            textField.placeholder = "Your Phone Number..."
          }
        alertController.addTextField { (textField) in
            textField.placeholder = "Write your Note..."
          }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let textName = alertController.textFields?.first?.text else {return}
            guard let textPhone = alertController.textFields?[1].text else {return}
            guard let textNote = alertController.textFields?[2].text else {return}
            
            print("\(textName)--\(textPhone)--\(textNote)")
            
            let mBody: [String : Any] = [
                "name"  : "\(textName)",
                "phone" : "\(textPhone)",
                "note"  : "\(textNote)"
            ]
           self.customerRepository.postUserData(body: mBody) { (userPostModel) in
                print("Success: \(userPostModel.result)")
             self.loadMyData()
          }
      }))
        self.present(alertController, animated: true)
    }
 //  POST Method...
 func setupContainer(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.separatorColor = UIColor.blue 
    }
    
    func loadMyData() {
        customerRepository.getCustomerRequest(custId: "1") { success in
            print(success)
          
            if let md = success.users {
                self.myData = md
            }
          self.tableView.reloadData()
        }
    }
}

extension  ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
     
        if let md = myData?[indexPath.row] {
            cell.idLbl.text = "ID: \(md.id ?? "")"
            cell.nameLbl.text  = "Name: \(md.name ?? "")"
            cell.phoneLbl.text = "Phone NO: \(md.phone ?? "")"
            cell.noteLbl.text = "Note: \(md.note ?? "")"
            cell.editBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(updateData(_:)), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteData(_:)), for: .touchUpInside)
       }
      return cell
    }

    @objc func updateData(_ sender: UIButton) {
        if let md = myData?[sender.tag] {
            // todo show alert to update data
            let alertController = UIAlertController(title: "Update", message: "Update Your Information", preferredStyle: .alert)
//            alertController.addTextField { textfield in
//                textfield.placeholder = "ID..."
//            }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Your Name..."
                    textField.text = "\(md.name ?? "")"
                  }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Your Phone Number..."
                    textField.text = "\(md.phone  ?? "")"
                  }
                alertController.addTextField { (textField) in
                    textField.placeholder = "Write your Note..."
                    textField.text = "\(md.note  ?? "")"
                  }
           
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //   guard let textId = alertController.textFields?.first?.text else {return}
                guard let textName = alertController.textFields?[0].text else {return}
                guard let textPhone = alertController.textFields?[1].text else {return}
                guard let textNote = alertController.textFields?[2].text else {return}
             print("\(textName)--\(textPhone)--\(textNote)")
               
                let mBody: [String : Any] = [
                    "id"    : "\(md.id ?? "")",
                    "name"  : "\(textName)",
                    "phone" : "\(textPhone)",
                    "note"  : "\(textNote)"
                ]
              self.customerRepository.putUserData(body: mBody) { (userPutModel) in
                    print("Success: \(userPutModel.result )")
                    self.loadMyData()
              }
         }))
            self.present(alertController, animated: true)
            // when click on ok call update api
            // call get api to refresh data
       }
    }

    @objc func deleteData(_ sender: UIButton) {
        if let md = myData?[sender.tag] {
            // todo show alert before delete
            
            let alertController = UIAlertController(title: "Alert!", message: "Do you want to delete \"\(md.name ?? "")\"?", preferredStyle: .alert)
//            alertController.addTextField { textfield in
//                textfield.placeholder = "ID..."
//   }
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
           // guard let textId = alertController.textFields?.first?.text else {return}
          // print("\(textId)")
            let mBody: [String : Any] = [
                    "id"    : "\(md.id ?? "")",
                ]
                self.customerRepository.DeleteUserData(body: mBody) { (userDeleteModel) in
                    print("Success: \(userDeleteModel.result)")
                    self.loadMyData()
                }
        }))
            self.present(alertController, animated: true)
            // when click on ok call update api
            // call get api to refresh data
            
        }
    }
}
    
