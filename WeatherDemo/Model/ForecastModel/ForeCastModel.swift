import Foundation

public class ForeCastModel {
    
	public var lat: Double?
	public var lon: Double?
	public var timezone: String?
	public var timezone_offset: Int?
	public var hourly: Array<Hourly>?
	public var daily: Array<Daily>?

    public class func modelsFromDictionaryArray(array: NSArray) -> [ForeCastModel] {
        var models: [ForeCastModel] = []
        for item in array {
            models.append(ForeCastModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {
		lat = dictionary["lat"] as? Double
		lon = dictionary["lon"] as? Double
		timezone = dictionary["timezone"] as? String
		timezone_offset = dictionary["timezone_offset"] as? Int
        if (dictionary["hourly"] != nil) { hourly = Hourly.modelsFromDictionaryArray(array: dictionary["hourly"] as! NSArray) }
        if (dictionary["daily"] != nil) { daily = Daily.modelsFromDictionaryArray(array: dictionary["daily"] as! NSArray) }
	}

	public func dictionaryRepresentation() -> NSDictionary {
		let dictionary = NSMutableDictionary()
		dictionary.setValue(self.lat, forKey: "lat")
		dictionary.setValue(self.lon, forKey: "lon")
		dictionary.setValue(self.timezone, forKey: "timezone")
		dictionary.setValue(self.timezone_offset, forKey: "timezone_offset")
		return dictionary
	}

}
