//
//  ViewController.swift
//  Peek and Pop Demo
//
//  Created by Luís Machado on 08/08/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
            
            registerForPreviewingWithDelegate(self, sourceView: view)
            
        } else {
            print("3D not available!")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let peekViewController = storyboard?.instantiateViewControllerWithIdentifier("peekViewController") as! PeekViewController
        return peekViewController
    }
    
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        let popViewController = storyboard?.instantiateViewControllerWithIdentifier("popViewController") as! PopViewController
        
        showViewController(popViewController, sender: self)
    }
    
}

