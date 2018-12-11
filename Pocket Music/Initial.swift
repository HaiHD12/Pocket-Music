//
//  Initial.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/5/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//

import UIKit
import Foundation
import Firebase


class Initial: UIViewController {

    @IBOutlet var LoginButton: UIView!
    @IBOutlet weak var SignUpButton: ButtonFormat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addFadeBackground(top: primary, bottom: secondary)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toMain", sender: self)
        }
    }

}
