import Foundation

public class Hour {
    
	public var time_epoch: Int?
	public var time: String?
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
	public var windchill_c: Double?
	public var windchill_f: Double?
	public var heatindex_c: Double?
	public var heatindex_f: Double?
	public var dewpoint_c: Double?
	public var dewpoint_f: Double?
	public var will_it_rain: Int?
	public var chance_of_rain: Int?
	public var will_it_snow: Int?
	public var chance_of_snow: Int?
	public var vis_km: Double?
	public var vis_miles: Double?
	public var gust_mph: Double?
	public var gust_kph: Double?
	public var uv: Double?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Hour] {
        var models:[Hour] = []
        for item in array {
            models.append(Hour(dictionary: item as! NSDictionary)!)
        }
        return models
    }

	required public init?(dictionary: NSDictionary) {

		time_epoch = dictionary["time_epoch"] as? Int
		time = dictionary["time"] as? String
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
		windchill_c = dictionary["windchill_c"] as? Double
		windchill_f = dictionary["windchill_f"] as? Double
		heatindex_c = dictionary["heatindex_c"] as? Double
		heatindex_f = dictionary["heatindex_f"] as? Double
		dewpoint_c = dictionary["dewpoint_c"] as? Double
		dewpoint_f = dictionary["dewpoint_f"] as? Double
		will_it_rain = dictionary["will_it_rain"] as? Int
		chance_of_rain = dictionary["chance_of_rain"] as? Int
		will_it_snow = dictionary["will_it_snow"] as? Int
		chance_of_snow = dictionary["chance_of_snow"] as? Int
		vis_km = dictionary["vis_km"] as? Double
		vis_miles = dictionary["vis_miles"] as? Double
		gust_mph = dictionary["gust_mph"] as? Double
		gust_kph = dictionary["gust_kph"] as? Double
		uv = dictionary["uv"] as? Double
	}

    public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.time_epoch, forKey: "time_epoch")
		dictionary.setValue(self.time, forKey: "time")
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
		dictionary.setValue(self.windchill_c, forKey: "windchill_c")
		dictionary.setValue(self.windchill_f, forKey: "windchill_f")
		dictionary.setValue(self.heatindex_c, forKey: "heatindex_c")
		dictionary.setValue(self.heatindex_f, forKey: "heatindex_f")
		dictionary.setValue(self.dewpoint_c, forKey: "dewpoint_c")
		dictionary.setValue(self.dewpoint_f, forKey: "dewpoint_f")
		dictionary.setValue(self.will_it_rain, forKey: "will_it_rain")
		dictionary.setValue(self.chance_of_rain, forKey: "chance_of_rain")
		dictionary.setValue(self.will_it_snow, forKey: "will_it_snow")
		dictionary.setValue(self.chance_of_snow, forKey: "chance_of_snow")
		dictionary.setValue(self.vis_km, forKey: "vis_km")
		dictionary.setValue(self.vis_miles, forKey: "vis_miles")
		dictionary.setValue(self.gust_mph, forKey: "gust_mph")
		dictionary.setValue(self.gust_kph, forKey: "gust_kph")
		dictionary.setValue(self.uv, forKey: "uv")

		return dictionary
	}

}
