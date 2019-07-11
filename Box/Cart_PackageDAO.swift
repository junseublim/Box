//
//  Cart_PackageDAO.swift
//  Box
//
//  Created by Jun Seub Lim on 11/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
//
class Cart_PackageDAO {
    typealias Cart_PackageRecord = (String, String, String, Int, Int)
    
    lazy var fmdb: FMDatabase! = {
        let fileMgr = FileManager.default
        
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("Cart.sqlite").path
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "Cart", ofType: "sqlite")
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
    
    func find() -> [Cart_PackageRecord] {
        var packageList = [Cart_PackageRecord]()
        do {
            let sql = """
                SELECT package_id, package_name, package_image, package_price, package_amount
                FROM Cart_Package
            """
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            while rs.next() {
                let package_id = rs.string(forColumn: "package_id")
                let package_name = rs.string(forColumn: "package_name")
                let package_image = rs.string(forColumn: "package_image")
                let package_price = rs.int(forColumn: "package_price")
                let package_amount = rs.int(forColumn: "package_amount")
                packageList.append((package_id!,package_name!, package_image!, Int(package_price), Int(package_amount)))
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return packageList
    }
    func create(package_id: String!,package_name: String!, package_image: String!, package_price: Int!, package_amount: Int!) -> Bool {
        do {
            let sql = """
        INSERT INTO Cart_Package (package_id, package_name, package_image, package_price, package_amount)
        VALUES ( ? , ? , ? , ? , ? )
      """
            
            try self.fmdb.executeUpdate(sql, values: [package_id!, package_name!, package_image!, package_price!, package_amount!])
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    func remove(package_id: String) -> Bool {
        do {
            let sql = """
            DELETE FROM Cart_Package WHERE package_id = ?
            """
            try self.fmdb.executeUpdate(sql, values: [package_id])
            return true
        } catch let error as NSError {
            print("DELETE Error: \(error.localizedDescription)")
            return false
        }
    }
    
}

