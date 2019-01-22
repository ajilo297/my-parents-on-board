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
    
    // Hidden methods
    private static func insertStreamData(context: NSManagedObjectContext, streamModel: StreamDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "Streamdata", in: context)
        let urls = NSManagedObject(entity: entity!, insertInto: context)
        
        urls.setValue(streamModel.id, forKey: "id")
        urls.setValue(streamModel.videoUrl, forKey: "cameraUrl")
        urls.setValue(streamModel.videoName, forKey: "cameraName")
        urls.setValue(streamModel.streamType, forKey: "streamType")
        urls.setValue(streamModel.thumbnailUrl, forKey: "thumbUrl")
        
        do {
            try context.save()
            print("\(fileSaveSuccess): \(streamModel.id)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    private static func insertVodData(context: NSManagedObjectContext, vodmodel: VodDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "VodData", in: context)
        let urls = NSManagedObject(entity: entity!, insertInto: context)
        
        urls.setValue(vodmodel.videoUrl, forKey: "videoUrl")
        urls.setValue(vodmodel.filebaseName, forKey: "filebaseName")
        urls.setValue(vodmodel.thumbnailUrl, forKey: "thumbnailUrl")
        urls.setValue(vodmodel.videoName, forKey: "vodName")
        urls.setValue(vodmodel.vodType, forKey: "vodType")
        
        do {
            try context.save()
            print("\(fileSaveSuccess): \(vodmodel.filebaseName)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    private static func insertTeacherData(context: NSManagedObjectContext, teacherModel: TeacherDataModel){
        
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
            print("\(fileSaveSuccess): \(teacherModel.id)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    private static func insertChildData(context: NSManagedObjectContext, childModel: ChildDataModel){
        
        let entity = NSEntityDescription.entity(forEntityName: "Child", in: context)
        let urls = NSManagedObject(entity: entity!, insertInto: context)
        
        urls.setValue(childModel.childId, forKey: "childId")
        urls.setValue(childModel.firstName, forKey: "firstName")
        urls.setValue(childModel.lastName, forKey: "lastName")
        urls.setValue(childModel.pictureUrl, forKey: "pictureUrl")
        
        do {
            try context.save()
            print("\(fileSaveSuccess): \(childModel.childId)")
        } catch {
            print("\(fileSaveError)")
        }
    }
    
    private static func deleteStreamData(context: NSManagedObjectContext) -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Streamdata")
        let request =  NSBatchDeleteRequest(fetchRequest: fetch)
        return deleteData(context: context, request: request)
    }
    
    private static func deleteChildData(context: NSManagedObjectContext) -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Child")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        return deleteData(context: context, request: request)
    }
    
    private static func deleteTeacherData(context: NSManagedObjectContext) -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Teachers")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        return deleteData(context: context, request: request)
    }
    
    private static func deleteVodData(context: NSManagedObjectContext) -> Bool {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "VodData")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        return deleteData(context: context, request: request)
    }
    
    private static func deleteData(context: NSManagedObjectContext, request: NSBatchDeleteRequest) -> Bool {
        do {
            try context.execute(request)
            try context.save()
            return true
        } catch let e as NSError {
            print("\(e.localizedDescription)")
            return false;
        }
    }
    
    // MARK: - Exposed Methods
    
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
    
    public static func deleteOnLogout(context: NSManagedObjectContext) -> Bool {
        
        let resultVod = deleteVodData(context: context)
        let resultChild = deleteChildData(context: context)
        let resultStream = deleteStreamData(context: context)
        let resultTeacher = deleteTeacherData(context: context)
        
        return resultVod && resultChild && resultStream && resultTeacher;
    }
    
    public static func getStreamData(context: NSManagedObjectContext) -> Array<StreamDataModel>{
        
        var streamArray: Array<StreamDataModel> = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Streamdata")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! String
                let cameraUrl = data.value(forKey: "cameraUrl") as! String
                let thumbUrl = data.value(forKey: "thumbUrl") as! String
                let cameraName = data.value(forKey: "cameraName") as! String
                let streamType = data.value(forKey: "streamType") as! String
                
                let streamModel = StreamDataModel(id: id, cameraUrl: cameraUrl, thumbUrl: thumbUrl, streamType: streamType, cameraName: cameraName)
                streamArray.append(streamModel)
            }
        } catch {
            print("Failed")
        }
        return streamArray
    }
    
    public static func getVodData(context: NSManagedObjectContext) -> Array<VodDataModel>{
        
        var vodArray: Array<VodDataModel> = []
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VodData")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let filebaseName = data.value(forKey: "filebaseName") as! String
                let videoUrl = data.value(forKey: "videoUrl") as! String
                let thumbnailUrl = data.value(forKey: "thumbnailUrl") as! String
                let vodName = data.value(forKey: "vodName") as! String
                let streamType = data.value(forKey: "vodType") as! String
                
                let vodModel = VodDataModel(videoUrl: videoUrl, filebaseName: filebaseName, thumbnailUrl: thumbnailUrl, vodName: vodName, vodType: streamType)
                vodArray.append(vodModel)
            }
        } catch {
            print("Failed")
        }
        return vodArray
    }
}
