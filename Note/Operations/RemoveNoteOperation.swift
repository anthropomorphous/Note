//
//  RemoveNoteOperation.swift
//  Note
//
//  Created by ios_school on 3/6/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import Foundation

class RemoveNoteOperation: AsyncOperation {
    private let removeFromDb: RemoveNoteDBOperation
    private let dbQueue: OperationQueue
    
    private(set) var result: Bool? = false
    
    init(note: Note,
         notebook: FileNotebook,
         backendQueue: OperationQueue,
         dbQueue: OperationQueue) {

        removeFromDb = RemoveNoteDBOperation(note: note, notebook: notebook)
        self.dbQueue = dbQueue

        super.init()

        removeFromDb.completionBlock = {
            let removeFromBackend = RemoveNotesBackendOperation(notes: notebook.notesArray)
            removeFromBackend.completionBlock = {
                switch removeFromBackend.result! {
                case .success:
                    self.result = true
                case .failure:
                    self.result = false
                }
                self.finish()
            }
            backendQueue.addOperation(removeFromBackend)
        }
    }

    override func main() {
        dbQueue.addOperation(removeFromDb)
    }
}
