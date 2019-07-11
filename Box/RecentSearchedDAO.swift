//
//  RecentSearchedDAO.swift
//  Box
//
//  Created by Jun Seub Lim on 11/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//

class RecentSearchedDAO {

    
    lazy var fmdb: FMDatabase! = {
        let fileMgr = FileManager.default
        
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("Recent.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "Recent", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    init() {
        self.fmdb.open()
    }
    deinit {
        self.fmdb.close()
    }
    
    func find() -> [String] {
        var searchedList = [String]()
        do {
            let sql = """
                SELECT Search
                FROM Recent
            """
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            while rs.next() {
                let searched = rs.string(forColumn: "Search")
                searchedList.append(searched!)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return searchedList
    }
    func create(searched: String) -> Bool {
        do {
            let sql = """
        INSERT INTO Recent (Search)
        VALUES ( ? )
      """
            
            try self.fmdb.executeUpdate(sql, values: [searched])
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    func remove(searched: String) -> Bool {
        do {
            let sql = """
            DELETE FROM Recent WHERE Search = ?
            """
            try self.fmdb.executeUpdate(sql, values: [searched])
            return true
        } catch let error as NSError {
            print("DELETE Error: \(error.localizedDescription)")
            return false
        }
    }
    
}
