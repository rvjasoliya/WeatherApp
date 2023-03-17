import Foundation

public class Sys {
    
	public var type: Int?
	public var id: Int?
	public var country: String?
	public var sunrise: Int?
	public var sunset: Int?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Sys] {
        var models: [Sys] = []
        for item in array {
            models.append(Sys(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		type = dictionary["type"] as? Int
		id = dictionary["id"] as? Int
		country = dictionary["country"] as? String
		sunrise = dictionary["sunrise"] as? Int
		sunset = dictionary["sunset"] as? Int
	}
		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.type, forKey: "type")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.country, forKey: "country")
		dictionary.setValue(self.sunrise, forKey: "sunrise")
		dictionary.setValue(self.sunset, forKey: "sunset")

		return dictionary
	}

}
