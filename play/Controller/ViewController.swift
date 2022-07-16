//
//  ViewController.swift
//  play
//
//  Created by Sachin Jadhav on 16/07/22.
//

import UIKit

class ViewController: UIViewController {

    var NewsData  = [all]()

    @IBOutlet weak var tbl: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tbl.register(UINib(nibName: "TableViewCells", bundle: nil), forCellReuseIdentifier: "cell")
        
        GetValue()
    }


    func GetValue()
    {
        
        //loader.shared.showActivity(myView: self.view, myTitle: "Loading")
        
      //  loader()
        
        var urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2c293061299c46458f6319c896c4beaa")!)
        
        URLSession.shared.dataTask(with: urlRequest) { [self] (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            
            {
                
                //loader.shared.removeActivity(myView: self.view)
                
               // let loader =   self.loader()
               //self.stopLoader(loader: loader)
                
                let decoder = JSONDecoder()
                do {
                    let result  = try decoder.decode(News.self, from: responseData!)
                    
                    
                    self.NewsData = result.articles

                    
                    
                    DispatchQueue.main.async {
                   // loader.shared.removeActivity(myView: self.view)

                        self.tbl.reloadData()
                    }
                    
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                }
            }

        }.resume()
    }
}



extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  NewsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tbl.dequeueReusableCell(withIdentifier:
                     "cell", for: indexPath)
                     as! TableViewCells

        let news  = NewsData[indexPath.row]
        
        cell.author.text = "Author : \(news.author!)"
        cell.descriptions.text = "Description :\(news.description!)"
        cell.title.text = "Title: \(news.title!)"
        
        let animalImageUrl = URL(string: (news.urlToImage)!)!
       
       cell.img.loadImage(fromURL: animalImageUrl, placeHolderImage: "LaunchImage")
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = NewsData[indexPath.row].url
        

        
                    let detailVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
                detailVC.urls = url
        
                self.navigationController?.pushViewController(detailVC, animated: true)
           
    }
    
    

   
}
