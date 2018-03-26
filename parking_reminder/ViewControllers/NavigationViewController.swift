//
//  NavigationViewController.swift
//  parking_reminder
//
//  Created by Vincent Lee on 3/25/18.
//  Copyright © 2018 Vincent Lee. All rights reserved.
//

import UIKit
import CoreData

class NavigationViewController: UINavigationController {
    var objectContext: NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarController = parent as! TabBarViewController
        objectContext = tabBarController.objectContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
