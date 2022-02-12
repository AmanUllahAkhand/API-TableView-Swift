//
//  CustomerRepository.swift
//  GetApiTableView
//
//  Created by USER on 10/02/2022.
//

import UIKit

class CustomerRepository: NSObject {
 
    func getCustomerRequest(custId: String, completion: @escaping (_ success: MyModel) -> Void) {
        
        let fullUrl = AllApi.CUSTOMER_REQUEST + "?page=\(custId)"
        print(fullUrl)
        var request = URLRequest(url: URL(string: fullUrl)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 120 // 120 sec
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let myData = data, error == nil else { return }
            do {
                print(myData)
                let responseModel = try JSONDecoder().decode(MyModel.self, from: myData )
                DispatchQueue.main.async {
                    completion(responseModel)
                }
            } catch let err {
                print(err)
            }
        }.resume()
         
    } // getCustomerRequest

    func postUserData(body: [String : Any],
                      completion: @escaping (_ success: UserDataPostModel) -> Void) {
        
        let fullUrl = AllApi.CUSTOMER_REQUEST
        print(fullUrl)
        var request = URLRequest(url: URL(string: fullUrl)!)
        request.httpMethod = "POST"
        request.timeoutInterval = 120 // 120 sec
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let myData = data, error == nil else { return }
            do {
                print(myData)
                let responseModel = try JSONDecoder().decode(UserDataPostModel.self, from: myData )
                DispatchQueue.main.async {
                    completion(responseModel)
                }
            } catch let err {
                print(err)
            }
        }.resume()
         
    } // postUserData
    
    
    func putUserData(body: [String : Any],
                      completion: @escaping (_ success: UserDataPostModel) -> Void) {
        
        let fullUrl = AllApi.CUSTOMER_REQUEST
        print(fullUrl)
        var request = URLRequest(url: URL(string: fullUrl)!)
        request.httpMethod = "PUT"
        request.timeoutInterval = 120 // 120 sec
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let myData = data, error == nil else { return }
            do {
                print(myData)
                let responseModel = try JSONDecoder().decode(UserDataPostModel.self, from: myData )
                DispatchQueue.main.async {
                    completion(responseModel)
                }
            } catch let err {
                print(err)
            }
        }.resume()
         
    } // DeleteUserData
    func DeleteUserData(body: [String : Any],
                      completion: @escaping (_ success: UserDataPostModel) -> Void) {
        
        let fullUrl = AllApi.CUSTOMER_REQUEST
        print(fullUrl)
        var request = URLRequest(url: URL(string: fullUrl)!)
        request.httpMethod = "DELETE"
        request.timeoutInterval = 120 // 120 sec
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let myData = data, error == nil else { return }
            do {
                print(myData)
                let responseModel = try JSONDecoder().decode(UserDataPostModel.self, from: myData )
                DispatchQueue.main.async {
                    completion(responseModel)
                }
            } catch let err {
                print(err)
            }
        }.resume()
         
    } // DeleteUserData
    
    
    
}
