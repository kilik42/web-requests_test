//
//  ViewController.swift
//  web-requests_test
//
//  Created by marvin evins on 6/6/16.
//  Copyright © 2016 marvin evins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlString = "http://swapi.com/api/planets/1/"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseData = data {
                do{
                  let json =  try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                   
                    if let dict = json as? Dictionary<String, AnyObject>{
                        
                       // print("Did we get here: \(dict.debugDescription)")
                        if let name = dict["name"] as? String, let height = dict["height"] as? String, let birth = dict["birth_year"] as? String, let hair = dict["hair_color"] as? String{
                            let person = SWPerson(name: name , height: height, birthYear: birth, hairColor: hair)
                           print(person.name)
                           print(person.height)
                           print(person.hairColor)
                           print(person.birthYear)
                            
                            if let films = dict["films"] as? [String]{
                                for film in films {
                                    print(film)
                                }
                            }
                        }
                    }
                    
                    
                } catch{
                    
                    print("could not serialize")
                    
                }
                
                
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

