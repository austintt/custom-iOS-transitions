//
//  UIViewController+UnwindSegue.swift
//  custom-iOS-transitions
//
//  Created by Austin Tooley on 2/5/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit

public extension UIViewController {
    @IBAction public func unwindToViewController (_ segue : UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
