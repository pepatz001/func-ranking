- ใช้เวลาทำแบบทดสอบไปเท่าไร ถ้ามีเวลามากกว่านี้จะทำอะไรเพิ่ม ถ้าใช้เวลาน้อยในการทำโจทย์สามารถใช้โอกาสนี้ในการอธิบายได้ว่าอยากเพิ่มอะไร หรือแก้ไขในส่วนไหน
=> ใช้เวลาทั้งหมด 1 ชั่วโมงครึ่ง (เริ่ม 14/12/2564 8.30น. เสร็จ 14/12/2564 10.00น.) ถ้ามีเวลาเพิ่มอยากวางโครงสร้างการยิง API ใหม่โดยใช้ Alamofire และปรับ Design ให้สวยงามตามหลัก UI/UX และเปลี่ยนมาใช้ Design Pattern (เช่น Clean Architecture, MVVM) ในการ Develop ครับ

- อะไรคือ feature ที่นำเข้ามาใช้ในการพัฒนา application นี้ กรุณาแนบ code snippet มาด้วยว่าใช้อย่างไร ในส่วนไหน
=> มี feature ในการยิง api สำหรับดึงข้อมูล fund-ranking โดยใช้การ replace timeframe string ที่เลือกใน url เพื่อเปลี่ยน url ในการดึงข้อมูลในแต่ละ timeframe

```
let apiUrl: String = "https://storage.googleapis.com/finno-ex-re-v2-static-staging/recruitment-test/fund-ranking-%@.json"
let timeFrame = "1D"
let pathUrl = String(format: apiUrl, timeFrame)
guard let url = URL(string: pathUrl) else { return }
URLSession.shared.dataTask(with: url) { data, response, error in
    if let data = data {
        do {
            let response = try JSONDecoder().decode(FundRankingResponse.self, from: data)
            self.fundRankings = response.data

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch let error {
            print(error)
        }
    }
}.resume()
```

- เราจะสามารถติดตาม performance issue บน production ได้อย่างไร เคยมีประสบการณ์ด้านนี้ไหม
=> ไม่เคยครับ


- อยากปรับปรุง FINNOMENA APIs ที่ใช้ในการพัฒนา ในส่วนไหนให้ดียิ่งขึ้น
=> อยากให้มีการใช้ param ในการ filter ตัว timeframe ที่ดีกว่าการเปลี่ยนชื่อไฟล์ json ครับ
