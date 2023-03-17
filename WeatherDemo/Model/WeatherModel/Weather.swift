import Foundation

public class Weather {
	public var id: Int?
	public var main: String?
	public var description: String?
	public var icon: String?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Weather] {
        var models: [Weather] = []
        for item in array {
            models.append(Weather(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		id = dictionary["id"] as? Int
		main = dictionary["main"] as? String
		description = dictionary["description"] as? String
		icon = dictionary["icon"] as? String
	}

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.main, forKey: "main")
		dictionary.setValue(self.description, forKey: "description")
		dictionary.setValue(self.icon, forKey: "icon")

		return dictionary
	}

}
