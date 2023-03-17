import Foundation

public class Feels_like {
    
	public var day: Double?
	public var night: Double?
	public var eve: Double?
	public var morn: Double?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Feels_like] {
        var models: [Feels_like] = []
        for item in array {
            models.append(Feels_like(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		day = dictionary["day"] as? Double
		night = dictionary["night"] as? Double
		eve = dictionary["eve"] as? Double
		morn = dictionary["morn"] as? Double
	}

	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
		dictionary.setValue(self.day, forKey: "day")
		dictionary.setValue(self.night, forKey: "night")
		dictionary.setValue(self.eve, forKey: "eve")
		dictionary.setValue(self.morn, forKey: "morn")
		return dictionary
	}

}
