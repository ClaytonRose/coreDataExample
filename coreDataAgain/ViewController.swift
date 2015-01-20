//
//  ViewController.swift
//  coreDataAgain
//
//  Created by Clayton Rose on 2015-01-20.
//  Copyright (c) 2015 Matthew Cibulka Clayton Rose. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBAction func fetchPressed(sender: AnyObject) {
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Song")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            songs = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        for song in songs {
            println(song.valueForKey("title")!)
            println(song.valueForKey("album")!)
        }
    }
    
    @IBAction func deletePressed(sender: AnyObject) {
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        // delete all records
        for song in songs {
            managedContext.deleteObject(song)
        }
       
        // save context
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
    }
    @IBAction func savePressed(sender: AnyObject) {
        let appDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Song", inManagedObjectContext:managedContext)
        
        let song = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        // Set all of the song attributes
        song.setValue("new title", forKey: "title")
        song.setValue("new album", forKey: "album")
        
        // Save context
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }

        
        songs.append(song)
        
        println(songs)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

