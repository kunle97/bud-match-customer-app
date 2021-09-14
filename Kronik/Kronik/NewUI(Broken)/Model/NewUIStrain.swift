import SwiftyJSON
import Alamofire
class NewUIStrain{
    
    var id: Int
    
    var name: String?
    var race: String?
    
    var desc:String?
    var posEffects:[Any]?
    var negEffects:[Any]?
    var medEffects:[Any]?
    var flavors:[Any]?
 
    
    
    init(id:Int, name:String, race: String){
        self.id = id
        self.name = name
        self.race = race
        self.getDesc()
        self.getEffects()
        self.getFlavors()
    }
    
    init(json: JSON, index: Int){
        var data = json.arrayValue
        self.id = data[index]["id"].intValue
        self.name = data[index]["name"].stringValue
        self.race = data[index]["race"].stringValue
        self.getDesc()
        self.getEffects()
        self.getFlavors()
       print("\nStrain Initialized\n---------------------> \n id: \(self.id)\n Name: \(self.name) \n Race:\(self.race) \n Desc:\(self.desc)\n Positive Effects:\(self.posEffects) \n--------------------->\n")
        
        
    }
    
    func getDesc(){
        var url = "https://strainapi.evanbusse.com/mgvdv4j/strains/data/desc/\(String(describing: self.id))"
        AF.request(url).responseJSON{ response in
            var data = JSON(response.value)
            self.desc = data["desc"].stringValue
            //print("ID: \(self.id) Descr: \(data["desc"].stringValue)")
            
        }
    }
    func getEffects(){
        var url = "https://strainapi.evanbusse.com/mgvdv4j/strains/data/effects/\(String(describing: self.id))"
        AF.request(url).responseJSON{ response in
            var data = JSON(response.value)
            self.posEffects = data["positive"].arrayValue
            self.negEffects = data["negative"].arrayValue
            self.medEffects = data["medical"].arrayValue
            //print("ID: \(self.id) Pos Effects: \(self.posEffects) \n Neg Effects: \(self.negEffects) \n Medical: \(self.medEffects)")
        }
    }
    func getFlavors(){
        var url = "https://strainapi.evanbusse.com/mgvdv4j/strains/data/flavors/\(self.id)"
        AF.request(url).responseJSON{ response in
            var data = JSON(response.value)
            self.flavors = data.arrayValue
            //print("ID: \(self.id) Flavors: \(self.flavors)")
        }
    }
}
