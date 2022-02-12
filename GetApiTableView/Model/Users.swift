
import Foundation

struct Users: Codable {

  var id    : String? = nil
  var name  : String? = nil
  var phone : String? = nil
  var note  : String? = nil

  enum CodingKeys: String, CodingKey {

    case id    = "id"
    case name  = "name"
    case phone = "phone"
    case note  = "note"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id    = try values.decodeIfPresent(String.self , forKey: .id    )
    name  = try values.decodeIfPresent(String.self , forKey: .name  )
    phone = try values.decodeIfPresent(String.self , forKey: .phone )
    note  = try values.decodeIfPresent(String.self , forKey: .note  )
 
  }

  init() {

  }

}