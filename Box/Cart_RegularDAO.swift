//
//  Cart_RegularDAO.swift
//  Box
//
//  Created by Jun Seub Lim on 11/07/2019.
//  Copyright © 2019 Jun Seub Lim. All rights reserved.
import UIKit
class Cart_RegularDAO {
    typealias Cart_RegularRecord = (String,String,String,Int, Int, Int)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
    
    func find() -> [Cart_RegularRecord] {
        var regularList = [Cart_RegularRecord]()
        do {
            let sql = """
                SELECT product_id, product_name, product_image, product_price, product_amount, product_duration
                FROM Cart_Regular
            """
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            while rs.next() {
                let product_id = rs.string(forColumn: "product_id")
                let product_name = rs.string(forColumn: "product_name")
                let product_image = rs.string(forColumn: "product_image")
                let product_price = rs.int(forColumn: "product_price")
                let product_amount = rs.int(forColumn: "product_amount")
                let product_duration = rs.int(forColumn: "product_duration")
                
                regularList.append((product_id!,product_name!,product_image!,Int(product_price), Int(product_amount), Int(product_duration)))
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return regularList
    }
    func create(product_id: String!,product_name: String!,product_image: String!, product_price: Int!, product_amount: Int!, product_duration: Int!) -> Bool {
        for item in appDelegate.periodicalCart {
            if product_id == item.id {
                return false
            }
        }
        do {
            let sql = """
        INSERT INTO Cart_Regular (product_id, product_name, product_image, product_price, product_amount, product_duration)
        VALUES ( ? , ? , ? , ? , ? , ? )
      """
            
            try self.fmdb.executeUpdate(sql, values: [product_id!,product_name!,product_image!,product_price!, product_amount!, product_duration!])
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    func remove(product_id: String) -> Bool {
        do {
            let sql = """
            DELETE FROM Cart_Regular WHERE product_id = ?
            """
            try self.fmdb.executeUpdate(sql, values: [product_id])
            return true
        } catch let error as NSError {
            print("DELETE Error: \(error.localizedDescription)")
            return false
        }
    }
    
}

