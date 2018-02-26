//
//  ViewController.swift
//  BetterNotes
//
//  Created by Marius Pirvulescu on 2/25/18.
//  Copyright © 2018 Trinketronics. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    var note : Notes? {
        didSet{
            textNote.text = note?.text
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var textNote: UITextView!
    
}

