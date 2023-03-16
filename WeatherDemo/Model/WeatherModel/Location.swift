import Foundation

public class Location {
	public var name: String?
	public var region: String?
	public var country: String?
	public var lat: Double?
	public var lon: Double?
	public var tz_id: String?
	public var localtime_epoch: Int?
	public var localtime: String?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Location] {
        var models: [Location] = []
        for item in array {
            models.append(Location(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		name = dictionary["name"] as? String
		region = dictionary["region"] as? String
		country = dictionary["country"] as? String
		lat = dictionary["lat"] as? Double
		lon = dictionary["lon"] as? Double
		tz_id = dictionary["tz_id"] as? String
		localtime_epoch = dictionary["localtime_epoch"] as? Int
		localtime = dictionary["localtime"] as? String
        
	}
		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.region, forKey: "region")
		dictionary.setValue(self.country, forKey: "country")
		dictionary.setValue(self.lat, forKey: "lat")
		dictionary.setValue(self.lon, forKey: "lon")
		dictionary.setValue(self.tz_id, forKey: "tz_id")
		dictionary.setValue(self.localtime_epoch, forKey: "localtime_epoch")
		dictionary.setValue(self.localtime, forKey: "localtime")

		return dictionary
	}

}
