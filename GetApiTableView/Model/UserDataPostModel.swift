//
//  UserDataPostModel.swift
//  GetApiTableView
//
//  Created by USER on 10/02/2022.
//

import Foundation

struct UserDataPostModel: Codable {

  var result : String? = nil

  enum CodingKeys: String, CodingKey {

    case result = "result"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    result = try values.decodeIfPresent(String.self , forKey: .result )
 
  }

  init() {

  }

}
