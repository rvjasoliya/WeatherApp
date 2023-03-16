import Foundation

public class Day {
    
	public var maxtemp_c: Double?
	public var maxtemp_f: Double?
	public var mintemp_c: Double?
	public var mintemp_f: Double?
	public var avgtemp_c: Double?
	public var avgtemp_f: Double?
	public var maxwind_mph: Double?
	public var maxwind_kph: Double?
	public var totalprecip_mm: Double?
	public var totalprecip_in: Double?
	public var totalsnow_cm: Double?
	public var avgvis_km: Double?
	public var avgvis_miles: Double?
	public var avghumidity: Double?
	public var daily_will_it_rain: Int?
	public var daily_chance_of_rain: Int?
	public var daily_will_it_snow: Int?
	public var daily_chance_of_snow: Int?
	public var condition: Condition?
	public var uv: Double?

    public class func modelsFromDictionaryArray(array: NSArray) -> [Day] {
        var models: [Day] = []
        for item in array {
            models.append(Day(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {

		maxtemp_c = dictionary["maxtemp_c"] as? Double
		maxtemp_f = dictionary["maxtemp_f"] as? Double
		mintemp_c = dictionary["mintemp_c"] as? Double
		mintemp_f = dictionary["mintemp_f"] as? Double
		avgtemp_c = dictionary["avgtemp_c"] as? Double
		avgtemp_f = dictionary["avgtemp_f"] as? Double
		maxwind_mph = dictionary["maxwind_mph"] as? Double
		maxwind_kph = dictionary["maxwind_kph"] as? Double
		totalprecip_mm = dictionary["totalprecip_mm"] as? Double
		totalprecip_in = dictionary["totalprecip_in"] as? Double
		totalsnow_cm = dictionary["totalsnow_cm"] as? Double
		avgvis_km = dictionary["avgvis_km"] as? Double
		avgvis_miles = dictionary["avgvis_miles"] as? Double
		avghumidity = dictionary["avghumidity"] as? Double
		daily_will_it_rain = dictionary["daily_will_it_rain"] as? Int
		daily_chance_of_rain = dictionary["daily_chance_of_rain"] as? Int
		daily_will_it_snow = dictionary["daily_will_it_snow"] as? Int
		daily_chance_of_snow = dictionary["daily_chance_of_snow"] as? Int
		if (dictionary["condition"] != nil) { condition = Condition(dictionary: dictionary["condition"] as! NSDictionary) }
		uv = dictionary["uv"] as? Double
        
	}
		
    public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.maxtemp_c, forKey: "maxtemp_c")
		dictionary.setValue(self.maxtemp_f, forKey: "maxtemp_f")
		dictionary.setValue(self.mintemp_c, forKey: "mintemp_c")
		dictionary.setValue(self.mintemp_f, forKey: "mintemp_f")
		dictionary.setValue(self.avgtemp_c, forKey: "avgtemp_c")
		dictionary.setValue(self.avgtemp_f, forKey: "avgtemp_f")
		dictionary.setValue(self.maxwind_mph, forKey: "maxwind_mph")
		dictionary.setValue(self.maxwind_kph, forKey: "maxwind_kph")
		dictionary.setValue(self.totalprecip_mm, forKey: "totalprecip_mm")
		dictionary.setValue(self.totalprecip_in, forKey: "totalprecip_in")
		dictionary.setValue(self.totalsnow_cm, forKey: "totalsnow_cm")
		dictionary.setValue(self.avgvis_km, forKey: "avgvis_km")
		dictionary.setValue(self.avgvis_miles, forKey: "avgvis_miles")
		dictionary.setValue(self.avghumidity, forKey: "avghumidity")
		dictionary.setValue(self.daily_will_it_rain, forKey: "daily_will_it_rain")
		dictionary.setValue(self.daily_chance_of_rain, forKey: "daily_chance_of_rain")
		dictionary.setValue(self.daily_will_it_snow, forKey: "daily_will_it_snow")
		dictionary.setValue(self.daily_chance_of_snow, forKey: "daily_chance_of_snow")
		dictionary.setValue(self.condition?.dictionaryRepresentation(), forKey: "condition")
		dictionary.setValue(self.uv, forKey: "uv")

		return dictionary
	}

}
