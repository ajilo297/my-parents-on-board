//
//  CoredataManager.swift
//  MyParentsOnBoard
//
//  Created by Bivin Chithra on 19/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation
import CoreData

public class CoredataManager{
    
    private static let fileSaveError = "File save error"
    private static let fileSaveSuccess = "File saved"
    
    public static func insertDataModel(context: NSManagedObjectContext, dataModel: DataModel) {
        
        if let streamModel = dataModel as? StreamDataModel {
            insertStreamData(context: context, streamModel: streamModel)
            return
        }
        
        if let teacherModel = dataModel as? TeacherDataModel {
            insertTeacherData(context: context, teacherModel: teacherModel)
            return
        }
        
        if let vodModel = dataModel as? VodDataModel {
            insertVodData(context: context, vodmodel: vodModel)
            return
        }
        
        if let childModel = dataModel as? ChildDataModel {
            insertChildData(context: context, childModel: childModel)
            return
        }
    }
    
    public static func insertStreamData(context: NSManagedObjectContext, streamModel: StreamDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "Streamdata", in: context)
        let urls = NSManagedObject(entity: entity!, insertInto: context)
        
        urls.setValue(streamModel.id, forKey: "id")
        urls.setValue(streamModel.videoUrl, forKey: "cameraUrl")
        urls.setValue(streamModel.videoName, forKey: "cameraName")
        urls.setValue(streamModel.streamType, forKey: "streamType")
        urls.setValue(streamModel.thumbnailUrl, forKey: "thumbUrl")
        
        do {
            try context.save()
            print("\(fileSaveSuccess)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    public static func insertVodData(context: NSManagedObjectContext, vodmodel: VodDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "VodData", in: context)
        let urls = NSManagedObject(entity: entity!, insertInto: context)
        
        urls.setValue(vodmodel.videoUrl, forKey: "videoUrl")
        urls.setValue(vodmodel.filebaseName, forKey: "filebaseName")
        urls.setValue(vodmodel.thumbnailUrl, forKey: "thumbnailUrl")
        urls.setValue(vodmodel.videoName, forKey: "vodName")
        urls.setValue(vodmodel.vodType, forKey: "vodType")
        
        do {
            try context.save()
            print("\(fileSaveSuccess)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    public static func insertTeacherData(context: NSManagedObjectContext, teacherModel: TeacherDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "Teachers", in: context)
        let urls = NSManagedObject(entity: entity!, insertInto: context)
        
        urls.setValue(teacherModel.id, forKey: "teacherId")
        urls.setValue(teacherModel.firstName, forKey: "firstName")
        urls.setValue(teacherModel.lastName, forKey: "lastName")
        urls.setValue(teacherModel.dateOfBirth, forKey: "dateOfBirth")
        urls.setValue(teacherModel.email, forKey: "email")
        urls.setValue(teacherModel.phone, forKey: "phone")
        urls.setValue(teacherModel.position, forKey: "position")
        urls.setValue(teacherModel.workHours, forKey: "workHours")
        urls.setValue(teacherModel.education, forKey: "education")
        urls.setValue(teacherModel.certifications, forKey: "certifications")
        urls.setValue(teacherModel.biography, forKey: "biography")
        urls.setValue(teacherModel.pictureUrl, forKey: "pictureUrl")
        urls.setValue(teacherModel.age, forKey: "age")
        
        do {
            try context.save()
            print("\(fileSaveSuccess)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    public static func insertChildData(context: NSManagedObjectContext, childModel: ChildDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "Child", in: context)
        let urls = NSManagedObject(entity: entity!, insertInto: context)
        
        urls.setValue(childModel.childId, forKey: "childId")
        urls.setValue(childModel.firstName, forKey: "firstName")
        urls.setValue(childModel.lastName, forKey: "lastName")
        urls.setValue(childModel.pictureUrl, forKey: "pictureUrl")
        
        do {
            try context.save()
            print("\(fileSaveSuccess)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    public static func getStreamData(context: NSManagedObjectContext){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Streamdata")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! String)
            }
        } catch {
            print("Failed")
        }
    }
}
