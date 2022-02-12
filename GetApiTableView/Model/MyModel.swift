
import Foundation

struct MyModel: Codable {

  var message : String?  = nil
  var users   : [Users]? = []

  enum CodingKeys: String, CodingKey {

    case message = "message"
    case users   = "users"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    message = try values.decodeIfPresent(String.self  , forKey: .message )
    users   = try values.decodeIfPresent([Users].self , forKey: .users   )
 
  }

  init() {

  }

}