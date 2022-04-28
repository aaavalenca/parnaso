//
//  ViewController.swift
//  Parnaso
//
//  Created by aaav on 24/03/22.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var infos: UITableView!

    @IBOutlet var pegarData: UIDatePicker!
    
    @IBOutlet var word: UITextField!
    @IBOutlet var square: UIView!
    @IBOutlet var palavra: UITextView!
    @IBOutlet var contagem: UITextView!
    @IBOutlet var silabas: UITextView!
    
    var resultado : [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultado.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cria um template para célula, que pode ser reutilizado
        // em todas as outras células, caso você queira que
        // elas sejam iguais, mas com conteúdos diferentes
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StringCell", for: indexPath) as! StringCell
        cell.textLabel?.text = resultado[indexPath.row]


        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infos.dataSource = self
        self.infos.register(StringCell.self, forCellReuseIdentifier: "StringCell")
        self.infos.layer.cornerRadius = 5
        
    }
    
    @IBAction func calc(_ sender: Any) {
        resultado = []
        
        let p : String = word.text!
        let n : String = String(stringNum(p))
        
        makeRequest(p)
        resultado.append(p)
        resultado.append(n + " letras")
        self.infos.reloadData()
        
    }

    //  conta o número de letras
    func stringNum(_ p : String) -> Int {
        var num = 0;
        for _ in p {
            num += 1
        }
        return num
    }
    
    private func makeRequest(_ s : String){
        let u : String = "https://significado.herokuapp.com/v2/silabas/" + s
        
        let urlString = u.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                let httpResponse = response as? HTTPURLResponse
                let word = String(data: data, encoding: .utf8)
                DispatchQueue.main.async {
                    if (httpResponse?.statusCode == 200){
                    let s = word!.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: "\"", with: "") + " (\(word!.components(separatedBy: ",").count) sílabas)"
                    
                    self.resultado.append(s)
                    } else {
                        self.resultado.append("sem registro de sílabas")
                    }
                    self.infos.reloadData()

                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
}
