import Foundation

public class Temp {
    
	public var day: Double?
	public var min: Double?
	public var max: Double?
	public var night: Double?
	public var eve: Double?
	public var morn: Double?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Temp] {
        var models: [Temp] = []
        for item in array {
            models.append(Temp(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		day = dictionary["day"] as? Double
		min = dictionary["min"] as? Double
		max = dictionary["max"] as? Double
		night = dictionary["night"] as? Double
		eve = dictionary["eve"] as? Double
		morn = dictionary["morn"] as? Double
	}

	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
		dictionary.setValue(self.day, forKey: "day")
		dictionary.setValue(self.min, forKey: "min")
		dictionary.setValue(self.max, forKey: "max")
		dictionary.setValue(self.night, forKey: "night")
		dictionary.setValue(self.eve, forKey: "eve")
		dictionary.setValue(self.morn, forKey: "morn")
		return dictionary
	}

}
