//
//  ViewController.swift
//  TableStory
//
//  Created by Goodlow, Avery on 3/20/24.
//

import UIKit
import MapKit

//array objects of our data.

let data = [
Item(name: "Leopard Lounge", neighborhood: "North Loop", desc: "Leopard Lounge has been known to have the best curated selection of vintage in Texas for over 20 years. Leopard Lounge continues to be the go-to spot in Texas for true vintage, Americana and 1920’s – 2000’s clothing.", lat: 30.299040, long: -97.741135, imageName: "IMG_4054"),
Item(name: "Buffalo Exchange", neighborhood: "North Campus", desc: "Hip chain that buys, sells, trades trendy vintage & used clothing plus accessories for men & women. Thrift for all genders.", lat: 30.293440, long: -97.741445, imageName: "IMG_4067"),
Item(name: "Stitches Vintage", neighborhood: "North Loop", desc: "Americana boutique vintage store located in Austin, TX. On the historic street of North Loop.", lat: 30.315506, long: -97.724354, imageName: "IMG_4200"),
Item(name: "Ermine Vintage", neighborhood: "North Loop", desc: "Independent shop selling retro T-Shirts, jeans, shoes & funky accessories for men & women. Offers a curated selection of vintage-inspired jewelry and unique handcrafted items.", lat: 30.319142, long: -97.720668, imageName: "IMG_4201"),
Item(name: "Room Service Vintage", neighborhood: "North Loop", desc: "Quirky shop with a rotating supply of vintage furniture, decor, jewelry & more from the 50's-70's. A treasure trove for nostalgic shoppers.", lat: 30.319058, long: -97.719604, imageName: "IMG_4202"),
Item(name: "Big Bertha's Paradise", neighborhood: "North Loop", desc: "Boutique for womenswear from designer labels, some vintage, in petite, well-stocked digs. Showcasing emerging designers and local artisans.", lat: 30.318601, long: -97.719438, imageName: "IMG_4203"),
Item(name: "Blue Velvet", neighborhood: "North Loop", desc: "Funky, long-standing shop packed with men's & women's vintage clothing, costumes & accessories. Drawing fashion enthusiasts seeking one-of-a-kind pieces and rare finds.", lat: 30.319021, long: -97.718378, imageName: "IMG_4205"),
Item(name: "Revival Vintage", neighborhood: "North Loop", desc: "Mid-century modern to on-trend vintage furniture and decor located in Austin. Vintage unisex clothing, plants, and gift items. Creating a unique shopping experience in the heart of Austin.", lat: 30.321052, long: -97.721896, imageName: "IMG_4206"),
Item(name: "Uptown Modern", neighborhood: "Crestview", desc: "Refurbished European and American midcentury-modern furniture dealer that also sells jewelry.", lat: 30.326451, long: -97.738601, imageName: "IMG_4209"),
Item(name: "Thrift House", neighborhood: "Crestview", desc: "A volunteer-run resale department store that provides high-quality goods to our community. The store is open year-round and serves as a major source of income for Assistance League of Austin’s philanthropic programs.", lat: 30.327473, long: -97.739653, imageName: "IMG_4210"),
Item(name: "Prisma Vintage", neighborhood: "East Cesar Chavez", desc: "Vintage for everyone: all sizes & all eras! Offers vintage clothing and accessories spanning all sizes and eras, ensuring there's something special for every shopper to discover.", lat: 30.264670, long: -97.730190, imageName: "IMG_4474"),
Item(name: "Pavement (S. Lamar)", neighborhood: "Zilker", desc: "Pavement is a larger-than-life buy/sell/trade shop offering a wide variety of new and used clothing, shoes, and accessories. A favorite destination for both fashion-forward trendsetters and thrifty shoppers alike.", lat: 30.252320, long: -97.764130, imageName: "IMG_4475"),
Item(name: "City-Wide Garage Sale", neighborhood: "Bouldin Creek", desc: "This event features tons of vintage finds, antiques, estate jewelry and more! Keeping Austin vintage since 1977, the name “City-Wide” has become an iconic event held in Austin and surrounding towns multiple times a year.", lat: 30.258710, long: -97.751870, imageName: "IMG_4476"),
Item(name: "Charm School Vintage", neighborhood: "East Cesar Chavez", desc: "East Austin's mecca for must-have vintage clothing, handpicked with love and an eye for fun, functionality, and timeless style. Curated selection of clothing that celebrates individuality, creativity, and enduring fashion flair.", lat: 30.267078, long: -97.729471, imageName: "IMG_4492"),
Item(name: "Pavement (Guadalupe)", neighborhood: "North Campus", desc: "Pavement is a larger-than-life buy/sell/trade shop offering a wide variety of new and used clothing, shoes, and accessories. A favorite destination for both fashion-forward trendsetters and thrifty shoppers alike.", lat: 30.291918, long: -97.741159, imageName: "IMG_4052")
]


struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
                let item = data[indexPath.row]
                cell?.textLabel?.text = item.name

                //Add image references
                let image = UIImage(named: item.imageName)
                cell?.imageView?.image = image
                cell?.imageView?.layer.cornerRadius = 10
                cell?.imageView?.layer.borderWidth = 5
                cell?.imageView?.layer.borderColor = UIColor.white.cgColor
                
                return cell!
            }
                
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
    }
    
    // add this function to original ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetailSegue" {
          if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
              // Pass the selected item to the detail view controller
              detailViewController.item = selectedItem
          }
      }
  }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }

        
        
    }


}

