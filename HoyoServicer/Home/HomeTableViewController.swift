//
//  HomeTableViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/3/28.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit
import SVPullToRefresh


class HomeTableViewController: UITableViewController,CLLocationManagerDelegate {
    var  manager :CLLocationManager?
    var orders=[Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets=false
        tableView.registerNib(UINib(nibName: "HomeTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        //添加下拉加载数据事件
        tableView.addPullToRefreshWithActionHandler {
            [weak self] in
            if let strongSelf=self{
                strongSelf.refresh()
            }
        }
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CurrentUserDidChange), name: CurrentUserDidChangeNotificationName, object: nil)

     
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //定位
        manager = CLLocationManager()
        manager!.delegate=self
        manager!.desiredAccuracy = kCLLocationAccuracyBest
        manager!.distanceFilter = 10.0
        manager!.requestAlwaysAuthorization()
        manager!.startUpdatingLocation()
    }
    
    var addressDic=NSMutableDictionary()
    var pagesize = 10
    var pageindex = 0
    

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations[0]
       let o2d = newLocation.coordinate

        //let o2d = newLocation.coordinate
        manager.stopUpdatingLocation()
        let  geoC = CLGeocoder()
       
        geoC.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if(error == nil)
            {
                
                let placemark=placemarks?.first
            
               // addressDic?.setValue(<#T##value: AnyObject?##AnyObject?#>, forKey: <#T##String#>)
                print("===========\n");
                print("成功 %@",placemark?.classForCoder);
                print("地理名称%@",placemark!.name);
                print("街道名%@",placemark!.thoroughfare);
                print("国家%@",placemark!.country);
                print("城市%@",placemark!.locality);
                
                print("区: %@",placemark!.subLocality);
 
                print("==========\n");
               
                self.addressDic.setValue(10, forKey: "pagesize")
                self.addressDic.setValue(1, forKey: "pageindex")
        
               
                self.addressDic.setValue((placemark!.administrativeArea! as String), forKey: "province")
                self.addressDic.setValue((placemark!.locality! as String), forKey: "city")
          //  let  latitude =
                
                self.addressDic.setValue((o2d.latitude as NSNumber).stringValue, forKey: "lat")
               
                self.addressDic.setValue((o2d.longitude as NSNumber).stringValue, forKey: "lng")
  
                self.loadData("ywcation", orderby: "location")
            }else
            {
                print("错误");
            }
        }
        
    }
    
    func loadData(action :String,orderby : String){
    
        self.addressDic.setValue("location", forKey: "orderby")
        self.addressDic.setValue("ywcation", forKey: "action")
  
User.GetOrderList(self.addressDic, success: { orders in


//    or = order
 self.orders=orders
    print("成功.....-------")
 
    }) { (error) in
        
        print(error)
        }
        
    
    }

    
    func CurrentUserDidChange() {
        self.tableView.reloadData()
    }
     func refresh() {
        let success: (User) -> Void = {
            [weak self] user in
            if let self_ = self {
                User.currentUser=user
                self_.tableView.reloadData()
                self_.tableView.pullToRefreshView.stopAnimating()
            }
        }
        let failure: (NSError) -> Void = {
            [weak self] error in
            if let self_ = self {
               self_.tableView.pullToRefreshView.stopAnimating()
            }
        }
        User.RefreshIndex(success, failure: failure)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=true
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HEIGHT_SCREEN-HEIGHT_TabBar
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.selectionStyle=UITableViewCellSelectionStyle.None
        cell.buttonClickCallBack={ [weak self] buttonTag in
            if let strongSelf = self {
                strongSelf.buttonClick(buttonTag)
            }
            
        }
        cell.nameLabel.text = User.currentUser!.name
        if User.currentUser?.headimageurl != nil
        {
            cell.personImg.image=UIImage(data: (User.currentUser?.headimageurl)!)
        }
        cell.imageArray=[UIImage(named: "banner1"),UIImage(named: "banner2"),UIImage(named: "banner3")]
        return cell
    }
    
    /**
     点击菜单的哪个按钮
     
     - parameter Tag: 从左到右，从上到下，1、2....8
     */
    private func buttonClick(Tag:Int)
    {
        print(Tag)
        switch Tag {
        case 1:
            
            let robOneCon = RobListMianViewController()
            robOneCon.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(robOneCon, animated: true)
            break
        case 2:
            
            let pendingDoing = RobListOneController(title: "待处理")
            
            pendingDoing.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(pendingDoing, animated: true)
            
            break
        case 3:
            
            
            break
        case 4:
            
            break
        case 5:
            
            break
        case 6:
            
            break
        case  7:
            break
        case  8:
            let  myteam = MyTeamTableViewController()
           // myteam.hidesBottomBarWhenPushed = true
             self.navigationController?.pushViewController(myteam, animated: true)
            
            break
            
        default:
            break
            
        }

    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
