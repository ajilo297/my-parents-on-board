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
        let Urls = NSManagedObject(entity: entity!, insertInto: context)
        
        Urls.setValue(streamModel.id, forKey: "id")
        Urls.setValue(streamModel.cameraUrl, forKey: "cameraUrl")
        Urls.setValue(streamModel.cameraName, forKey: "cameraName")
        Urls.setValue(streamModel.streamType, forKey: "streamType")
        Urls.setValue(streamModel.thumbUrl, forKey: "thumbUrl")
        
        do {
            try context.save()
            print("File Saved")
        } catch {
            print("Failed saving")
        }
    }
    
    public static func insertVodData(context: NSManagedObjectContext, vodmodel: VodDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "VodData", in: context)
        let Urls = NSManagedObject(entity: entity!, insertInto: context)
        
        Urls.setValue(vodmodel.videoUrl, forKey: "videoUrl")
        Urls.setValue(vodmodel.filebaseName, forKey: "filebaseName")
        Urls.setValue(vodmodel.thumbnailUrl, forKey: "thumbnailUrl")
        Urls.setValue(vodmodel.vodName, forKey: "vodName")
        Urls.setValue(vodmodel.vodType, forKey: "vodType")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    public static func insertTeacherData(context: NSManagedObjectContext, teacherModel: TeacherDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "Teachers", in: context)
        let Urls = NSManagedObject(entity: entity!, insertInto: context)
        
        Urls.setValue(teacherModel.id, forKey: "teacherId")
        Urls.setValue(teacherModel.firstName, forKey: "firstName")
        Urls.setValue(teacherModel.lastName, forKey: "lastName")
        Urls.setValue(teacherModel.dateOfBirth, forKey: "dateOfBirth")
        Urls.setValue(teacherModel.email, forKey: "email")
        Urls.setValue(teacherModel.phone, forKey: "phone")
        Urls.setValue(teacherModel.position, forKey: "position")
        Urls.setValue(teacherModel.workHours, forKey: "workHours")
        Urls.setValue(teacherModel.education, forKey: "education")
        Urls.setValue(teacherModel.certifications, forKey: "certifications")
        Urls.setValue(teacherModel.biography, forKey: "biography")
        Urls.setValue(teacherModel.pictureUrl, forKey: "pictureUrl")
        Urls.setValue(teacherModel.age, forKey: "age")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    public static func insertChildData(context: NSManagedObjectContext, childModel: ChildDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "Child", in: context)
        let Urls = NSManagedObject(entity: entity!, insertInto: context)
        
        Urls.setValue(childModel.childId, forKey: "childId")
        Urls.setValue(childModel.firstName, forKey: "firstName")
        Urls.setValue(childModel.lastName, forKey: "lastName")
        Urls.setValue(childModel.pictureUrl, forKey: "pictureUrl")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
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
