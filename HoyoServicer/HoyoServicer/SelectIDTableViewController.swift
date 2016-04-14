//
//  SelectIDTableViewController.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/4/10.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//

import UIKit
protocol SelectIDTableViewControllerDelegate {
    func selectButtonChange(index:Int)
    func ToSelectAdressController()
    func SelectAdressFinished(adress:String)
}
class SelectIDTableViewController: UITableViewController,SelectIDTableViewControllerDelegate,UITextFieldDelegate {

    //1 首席合伙人,2一般合伙人,3联系工程师
    private var whitchCell = 1{
        didSet{
            if whitchCell==oldValue {
                return
            }
            self.tableView.reloadData()
        }
    }
    var chiefOfSelectIDCell:ChiefOfSelectIDCell?
    var generalOfSelectIDCell:GeneralOfSelectIDCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="选择身份"
        self.automaticallyAdjustsScrollViewInsets=false
        tableView.separatorStyle=UITableViewCellSeparatorStyle.None
        chiefOfSelectIDCell=NSBundle.mainBundle().loadNibNamed("ChiefOfSelectIDCell", owner: self, options: nil).last as? ChiefOfSelectIDCell
        chiefOfSelectIDCell?.delegate=self
        generalOfSelectIDCell=NSBundle.mainBundle().loadNibNamed("GeneralOfSelectIDCell", owner: self, options: nil).last as? GeneralOfSelectIDCell
        chiefOfSelectIDCell?.webSiteNameTextField.delegate=self
        chiefOfSelectIDCell?.detailAdressTextField.delegate=self
        generalOfSelectIDCell?.delegate=self
        generalOfSelectIDCell?.inputNumberTextField.delegate=self
        generalOfSelectIDCell?.commitbutton.addTarget(self, action: #selector(commitClick), forControlEvents: .TouchUpInside)
        chiefOfSelectIDCell?.commitbutton.addTarget(self, action: #selector(commitClick), forControlEvents: .TouchUpInside)
        chiefOfSelectIDCell?.selectionStyle=UITableViewCellSelectionStyle.None
        generalOfSelectIDCell?.selectionStyle=UITableViewCellSelectionStyle.None
    }
    func commitClick(button:UIButton) {
        let tmpStr:String?
        if button.tag==1 {
            tmpStr="首席工程师"
        }
        else
        {
            tmpStr=generalOfSelectIDCell?.selectIndex==22 ? "一般工程师":"联系工程师"
        }
        print(tmpStr)
        self.navigationController?.popViewControllerAnimated(true)
    }
    /**
     SelectIDTableViewControllerDelegate回掉方法
     */
    func selectButtonChange(index: Int) {
        whitchCell=index==21 ?1:index
    }
    //选择地址
    func ToSelectAdressController(){
        let jsonPath = NSBundle.mainBundle().pathForResource("china_citys", ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonPath!)! as NSData
        let tmpObject: AnyObject?
        do{
            tmpObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
        }
        let adressDic = tmpObject as! NSMutableArray
        let adressControll = SelectAdressTableViewController(adressData: adressDic, firstSelectRow: -1)
        adressControll.delegate=self
        self.navigationController?.pushViewController(adressControll, animated: true)

    }
    func SelectAdressFinished(adress:String)
    {
        chiefOfSelectIDCell?.cityLabel.text=adress
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden=false
        self.tabBarController?.tabBar.hidden=true
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
        let tmpHeight:CGFloat = whitchCell==1 ? 650:560
        
        return max(tmpHeight, (HEIGHT_SCREEN-HEIGHT_NavBar))
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if whitchCell != 1 {
            generalOfSelectIDCell?.selectIndex=whitchCell==2 ? 22:23
        }

        return whitchCell==1 ? chiefOfSelectIDCell!:generalOfSelectIDCell!
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
