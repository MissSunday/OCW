//
//  SwiftStudyVC.swift
//  OCW
//
//  Created by 王晓冉 on 2021/12/9.
//

import UIKit

class SwiftStudyVC: UIViewController {

    let a : String = "a";
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.navigationItem.title = NSStringFromClass(type(of: self))
        
        self.nav()
        print(a)
        
    }
    @objc func nav(){
        self.navigationController?.navigationBar.isTranslucent = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
