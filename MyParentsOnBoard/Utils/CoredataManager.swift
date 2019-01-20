//
//  CoredataManager.swift
//  MyParentsOnBoard
//
//  Created by Bivin Chithra on 19/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation
import CoreData

public class CoredataManagr{
    
    
    private static func insertData(appDelegate: AppDelegate, _id: String, cameraname: String, thumburl: String, streamingtype: String, cameraurl: String){
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Urls", in: context)
        let Urls = NSManagedObject(entity: entity!, insertInto: context)
        
        Urls.setValue(_id, forKey: "id")
        Urls.setValue(cameraname, forKey: "cameraname")
        Urls.setValue(thumburl, forKey: "thumburl")
        Urls.setValue(streamingtype, forKey: "streamtype")
        Urls.setValue(cameraurl, forKey: "cameraurl")
        
        do {
           try context.save()
            
        } catch {
            
            print("Failed saving")
        }
    }
}

