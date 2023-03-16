import Foundation

public class Current {
	
    public var last_updated_epoch: Int?
	public var last_updated: String?
	public var temp_c: Double?
	public var temp_f: Double?
	public var is_day: Int?
	public var condition: Condition?
	public var wind_mph: Double?
	public var wind_kph: Double?
	public var wind_degree: Int?
	public var wind_dir: String?
	public var pressure_mb: Double?
	public var pressure_in: Double?
	public var precip_mm: Double?
	public var precip_in: Double?
	public var humidity: Int?
	public var cloud: Int?
	public var feelslike_c: Double?
	public var feelslike_f: Double?
	public var vis_km: Double?
	public var vis_miles: Double?
	public var uv: Double?
	public var gust_mph: Double?
	public var gust_kph: Double?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Current] {
        var models: [Current] = []
        for item in array {
            models.append(Current(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		last_updated_epoch = dictionary["last_updated_epoch"] as? Int
		last_updated = dictionary["last_updated"] as? String
		temp_c = dictionary["temp_c"] as? Double
		temp_f = dictionary["temp_f"] as? Double
		is_day = dictionary["is_day"] as? Int
		if (dictionary["condition"] != nil) { condition = Condition(dictionary: dictionary["condition"] as! NSDictionary) }
		wind_mph = dictionary["wind_mph"] as? Double
		wind_kph = dictionary["wind_kph"] as? Double
		wind_degree = dictionary["wind_degree"] as? Int
		wind_dir = dictionary["wind_dir"] as? String
		pressure_mb = dictionary["pressure_mb"] as? Double
		pressure_in = dictionary["pressure_in"] as? Double
		precip_mm = dictionary["precip_mm"] as? Double
		precip_in = dictionary["precip_in"] as? Double
		humidity = dictionary["humidity"] as? Int
		cloud = dictionary["cloud"] as? Int
		feelslike_c = dictionary["feelslike_c"] as? Double
		feelslike_f = dictionary["feelslike_f"] as? Double
		vis_km = dictionary["vis_km"] as? Double
		vis_miles = dictionary["vis_miles"] as? Double
		uv = dictionary["uv"] as? Double
		gust_mph = dictionary["gust_mph"] as? Double
		gust_kph = dictionary["gust_kph"] as? Double
	}

		
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.last_updated_epoch, forKey: "last_updated_epoch")
		dictionary.setValue(self.last_updated, forKey: "last_updated")
		dictionary.setValue(self.temp_c, forKey: "temp_c")
		dictionary.setValue(self.temp_f, forKey: "temp_f")
		dictionary.setValue(self.is_day, forKey: "is_day")
		dictionary.setValue(self.condition?.dictionaryRepresentation(), forKey: "condition")
		dictionary.setValue(self.wind_mph, forKey: "wind_mph")
		dictionary.setValue(self.wind_kph, forKey: "wind_kph")
		dictionary.setValue(self.wind_degree, forKey: "wind_degree")
		dictionary.setValue(self.wind_dir, forKey: "wind_dir")
		dictionary.setValue(self.pressure_mb, forKey: "pressure_mb")
		dictionary.setValue(self.pressure_in, forKey: "pressure_in")
		dictionary.setValue(self.precip_mm, forKey: "precip_mm")
		dictionary.setValue(self.precip_in, forKey: "precip_in")
		dictionary.setValue(self.humidity, forKey: "humidity")
		dictionary.setValue(self.cloud, forKey: "cloud")
		dictionary.setValue(self.feelslike_c, forKey: "feelslike_c")
		dictionary.setValue(self.feelslike_f, forKey: "feelslike_f")
		dictionary.setValue(self.vis_km, forKey: "vis_km")
		dictionary.setValue(self.vis_miles, forKey: "vis_miles")
		dictionary.setValue(self.uv, forKey: "uv")
		dictionary.setValue(self.gust_mph, forKey: "gust_mph")
		dictionary.setValue(self.gust_kph, forKey: "gust_kph")

		return dictionary
	}

}
