//
//  AppDelegate.swift
//  cocoa_app_lrn
//
//  Created by stl on 2021/1/25.
//  Copyright © 2021 stl. All rights reserved.
//

import Cocoa
import Foundation
import CryptoSwift
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var json_list_text: String = ""

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        print("Hello, world!")
        // test crypto functions
        //testCryptoFunction()
        
        // gnerate BID
        //testGenerateBID()
        
        // test http request api (REST)
        //testHttpRequestAPI()
        
        // test api json
        //testApiJson()
        
        // test json list
        //testJsonList()
        
        // test swift closure functions
        testClosureFunction()
        

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("See you, world!")
    }
    
    func testClosureFunction(){
        let names = ["AT", "AE", "D", "S", "BE"]
        print(names)

        var reversed = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 < s2
        })
        
        print(reversed)
        
        reversed = names.sorted(by: >)
        print(reversed)
        
        //尾随闭包
        reversed = names.sorted() { $0 < $1 }
        print(reversed)
        
        //尾随闭包,只有一个参数可去除（）
        reversed = names.sorted { $0 > $1 }
        print(reversed)
        
    }
    
    func testJsonList(){
        print("============== json list ==============")
        do {
            print(json_list_text)
            let jsonData = json_list_text.data(using: .utf8)!
            let AccServers: [AccServerInfo] = try JSONDecoder().decode([AccServerInfo].self, from: jsonData)
            print(AccServers.count)
            print(AccServers[0].server)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func testApiJson(){
        print("============== json object ==============")
        let json_text = """
        {
        "code":0,
        "subCode":"1A03400",
        "message":"获取加速节点成功",
        "bodyMessage":"vfXi54tcuAwXW21xJPlu+ipaXxE9vGZ/sx30ujUQnPSLZHWE2QazeROwHAAqsyuNq3bS3B7wkHWg6U7MYG4S6YaaeexXxoUF66U8CYbWZwukZVSd0Yk3s7gwPeUUCBYs8SWck7tyx/fGSAh4VKM2MQmWbJX5IpokThd40E6rtOpF9vlCEl6ufMBLBt325uRb8rOdUeiAFLD7KPw3kMh561EcNmzv8birBdSx0KltI58he0neK8dIdKRpFAaGtpDdFmq3AdFZsx5K3LKEbFVO5pvLgfym1jP4Z7ao0nNT1fDf3KiFvgQgSg9RO08b0DIOoBMK1hIhsQkESJVZcjk9Cb7ewg6eDQ4eqStP6bSVZztw0tiiHe0m0anqFtU5d7MbLRzLNVjGov25KtY9IZslQQX3uJjW5TZ5IK0M8R6kf126cuORFVu2/koNvTuw+iXqeIqROKv54LOKwS86I8FHCf2gal5kyvhYBMWQjR8ZVhrpDmNfGICgdlV/nDQYXZ+o6a+OpoWXyHCXtuMyGshyHVJgEQ1X5wq4j2g3qrH4EnPx0fyN8xUhQTUsJ107mRpfGkJsCTIc2Jk+zgGyVyLM1D5pFWuC83DQjgQSN6wqvYihX/IrqlkPb7fo/xmqAxERfDsrthi1vSTSbFojYQm7DdvX17tRL303QiXYwqBVebcKTMfBDyL3FgoHdJvoafpGjep+WrC4ZYSiC5Y8MCF57zw04tp0sUGAN5hmap9tfDq5uCF3PerUvhKZognHeMBqscanlfNbH6yYS48FaIjtrUcMbGq88lc8st88IXJmao6rMwZjU1HIxjLYlU49zRsOUlB4LV7vQHhVEuT/6w4F/6p2kHcWeEMyepXUthRF27mbz5qJXLvdGy726LfGkJ/0dgGb4ynTKwlobrFIfdx6gaVeYt5YsHcYIp1cI9xvGvfeMmP5qafC6FIHaiTKnMWDu6p+i/M8Kv8paDmwTdLVoglmjLx3NY1AY6q7XwXQUAr2CuCMx0xQ2tpKw6cO/lsGvi3dEiJyOUqdTEwsnc/Nqhcx521uukTcb1Mz0ZerCsZRC2P4iP1M8KXDStEWyz/KAA+8n/ISthCGiIJdB8kppuLPWxsZw1z9rgRzRYig7G5ZfXE2yvtJPgY921DpZLddKOp+VTSJkvw6Xfc4KnM3+NVcH6tm9AOLiyiaV9pZWunpqNM31pP+xKQWV+0WeT4c0vaSCj2r1y1dTfXyVLf8lkFiufxWxsFYhgT19Lp0rRyHxastm5XtOLW/USTn70lxlX0Ug5SetItm8xHR0VupstOpqgSDgasUQwzUNwFylkOFxuUUEBubX8nAfPFQzlZ5f0smD9SQ064XhYTcg7yNVQ=="
        }
        """
        
        let jsonData = json_text.data(using: .utf8)!
        let response: ApiResponse = try! JSONDecoder().decode(ApiResponse.self, from: jsonData)
        print(response.code)
        print(response.subCode)
        print(response.message)
        print(response.bodyMessage)
    }
    
    func testHttpRequestAPI(){
        let url = URL(string: "http://120.24.168.112:31001/web/acceleration/findAccelerationInfo")!
        var request = URLRequest(url: url)
        request.addValue("vaMPMx+SJHY+lYYzYIG2qd7N/QaKLs/4fQSfnsFCIKocg1lfoIxoT0B0j+QgaLb7", forHTTPHeaderField: "Bid")
        
        // urlsession
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            // Check the response
            print("============== server http api request ==============")
            print(error ?? "no error")
            print(response ?? "None response")
            print(String(data: data!, encoding: String.Encoding.utf8) ?? "")
        })
        task.resume()
        
        // alamofire
        Alamofire.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("============== Alamofire server http api request ==============")
                print(json)
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
    
    func testGenerateBID(){
        print("============== UUID ==============")
        for _ in 1...10 {
            let uuid = UUID().uuidString
            print(uuid)
            print(uuid.split(separator: "-"))
        }
        
        print("============== datetime ==============")
        let  now =  Date()
        print(now)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.string(from: now)
        print(date)
        print(date.split(separator: "-"))
        let  timeInterval: TimeInterval  = now.timeIntervalSince1970
        let  timeStamp =  Int (timeInterval)
        print ( "timestamp：\(timeStamp)" )
        
        print("============== BID ==============")
        let uuid_split = UUID().uuidString.split(separator: "-")
        print(uuid_split)
        var date_split = date.split(separator: "-")
        // split the year text
        let year = date_split[2]
        date_split[2] = year.dropLast().dropLast()
        date_split.append(year.dropFirst(2))
        print(date_split)
        var BID = uuid_split[0]
        // 代码单行太长会编译出错，醉了
        for index in 0...3{
         BID = BID + date_split[index] + uuid_split[index+1]
        }
        print(BID)
    }
    
    func testCryptoFunction(){
        print("============== MD5 ==============")
        let hash = "123".md5()
        print("md5 of 123: \(hash)")
        
        print("============== Base64 ==============")
        let test_text: String = "Here is some data to encrypt!".toBase64String()
        print(test_text)
        var res_text = test_text.fromBase64String()
        print(res_text ?? "")
        let res_bytes = test_text.fromBase64()
        print(res_bytes ?? Array())
        res_text = String(bytes: res_bytes ?? Array(), encoding: .utf8) ?? ""
        print(res_text ?? "")
        
        
        print("============== AES ==============")
        let base64_key: String = "Wl7yV2/uqfwbuDLDUEQCIskld11RnGx50Npp2kTddAY="
        let base64_iv: String = "BGsKg5I1oEmsOik7Gl9Qxw=="
        let key = base64_key.fromBase64() ?? Array()
        let iv = base64_iv.fromBase64() ?? Array()
        print(key)
        print(iv)
        do {
            let aes_cbc = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
            let base64_crypt_message = "vfXi54tcuAwXW21xJPlu+ipaXxE9vGZ/sx30ujUQnPSLZHWE2QazeROwHAAqsyuNq3bS3B7wkHWg6U7MYG4S6YaaeexXxoUF66U8CYbWZwukZVSd0Yk3s7gwPeUUCBYs8SWck7tyx/fGSAh4VKM2MQmWbJX5IpokThd40E6rtOpF9vlCEl6ufMBLBt325uRb8rOdUeiAFLD7KPw3kMh561EcNmzv8birBdSx0KltI58he0neK8dIdKRpFAaGtpDdFmq3AdFZsx5K3LKEbFVO5pvLgfym1jP4Z7ao0nNT1fDf3KiFvgQgSg9RO08b0DIOoBMK1hIhsQkESJVZcjk9Cb7ewg6eDQ4eqStP6bSVZztw0tiiHe0m0anqFtU5d7MbLRzLNVjGov25KtY9IZslQQX3uJjW5TZ5IK0M8R6kf126cuORFVu2/koNvTuw+iXqeIqROKv54LOKwS86I8FHCf2gal5kyvhYBMWQjR8ZVhrpDmNfGICgdlV/nDQYXZ+o6a+OpoWXyHCXtuMyGshyHVJgEQ1X5wq4j2g3qrH4EnPx0fyN8xUhQTUsJ107mRpfGkJsCTIc2Jk+zgGyVyLM1D5pFWuC83DQjgQSN6wqvYihX/IrqlkPb7fo/xmqAxERfDsrthi1vSTSbFojYQm7DdvX17tRL303QiXYwqBVebcKTMfBDyL3FgoHdJvoafpGjep+WrC4ZYSiC5Y8MCF57zw04tp0sUGAN5hmap9tfDq5uCF3PerUvhKZognHeMBqscanlfNbH6yYS48FaIjtrUcMbGq88lc8st88IXJmao6rMwZjU1HIxjLYlU49zRsOUlB4LV7vQHhVEuT/6w4F/6p2kHcWeEMyepXUthRF27mbz5qJXLvdGy726LfGkJ/0dgGb4ynTKwlobrFIfdx6gaVeYt5YsHcYIp1cI9xvGvfeMmP5qafC6FIHaiTKnMWDu6p+i/M8Kv8paDmwTdLVoglmjLx3NY1AY6q7XwXQUAr2CuCMx0xQ2tpKw6cO/lsGvi3dEiJyOUqdTEwsnc/Nqhcx521uukTcb1Mz0ZerCsZRC2P4iP1M8KXDStEWyz/KAA+8n/ISthCGiIJdB8kppuLPWxsZw1z9rgRzRYig7G5ZfXE2yvtJPgY921DpZLddKOp+VTSJkvw6Xfc4KnM3+NVcH6tm9AOLiyiaV9pZWunpqNM31pP+xKQWV+0WeT4c0vaSCj2r1y1dTfXyVLf8lkFiufxWxsFYhgT19Lp0rRyHxastm5XtOLW/USTn70lxlX0Ug5SetItm8xHR0VupstOpqgSDgasUQwzUNwFylkOFxuUUEBubX8nAfPFQzlZ5f0smD9SQ064XhYTcg7yNVQ=="
            // use one
            let test_message = try base64_crypt_message.decryptBase64(cipher: aes_cbc)
//            let jsonData = Data(test_message)
//            let AccServers: [AccServerInfo] = try JSONDecoder().decode([AccServerInfo].self, from: jsonData)
//            print(AccServers.count)
            let test_message_text = String(bytes: test_message, encoding: .utf8) ?? ""
            print(test_message_text)
            json_list_text = test_message_text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            // use two
            let crypt_message = base64_crypt_message.fromBase64() ?? Array()
            // print(crypt_message)
            let decrypt_message = try aes_cbc.decrypt(crypt_message)
            // print(decrypt_message)
            let decrypt_message_text = String(bytes: decrypt_message, encoding: .utf8) ?? ""
            print(decrypt_message_text)
        } catch{
            print(error.localizedDescription)
        }
    }

}



