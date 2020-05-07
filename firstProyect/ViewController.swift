//
//  ViewController.swift
//  firstProyect
//
//  Created by junior on 5/6/20.
//  Copyright © 2020 junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var buttonClick: UIButton!

    @IBOutlet weak var pickerLista: UIPickerView!
    
    @IBOutlet weak var myPageControl: UIPageControl!
    
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    
    @IBOutlet weak var mySlider: UISlider!
    
    @IBOutlet weak var mySteper: UIStepper!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var myProgressView: UIProgressView!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var myTextField: UITextField!
    
    var lista = ["uno", "dos", "tres", "cuatro", "cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // MARK: - Text Field
        
        myTextField.textColor = .purple
        
        // podemos hacer un delegate con textfield
        myTextField.delegate = self
        
        // MARK: - button
        buttonClick.setTitle("Click", for: .normal)
        buttonClick.backgroundColor = .white
        
        // MARK: - Picker View
        // para añadir datos, tiene que ser con datasource y delegate
        // para decirle con que clase se poner self si es para refernciar que es en la misma vista, de lo contrario se poner otro, añadir los protocolos en viewController
        pickerLista.dataSource = self
        pickerLista.delegate = self
        
        // MARK: - PageControl
        
        // numero de paginas
        myPageControl.numberOfPages = 5
        // este es para mostrar el punto actual
        myPageControl.currentPageIndicatorTintColor = .blue
        
        //este es para indicar los tipos de avance ....
        myPageControl.pageIndicatorTintColor = .lightGray
        
        // MARK: -SegementControl
        // vaciado los elementos por defecto
        mySegmentControl.removeAllSegments()
        
        // añadiendo nuevos valores
        for (index, value) in lista.enumerated(){
             mySegmentControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // MARK: - Slider
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(lista.count)
        
        // MARK: - Stepper
        mySteper.minimumValue = 1
        mySteper.maximumValue = Double(lista.count)
        
        // MARK: - Switch
        mySwitch.onTintColor = .red
        mySwitch.isOn = false
        
        // MARK: - Progress view
        myProgressView.progress = 0
        
        
        // MARK: Activity Indicator
        myActivityIndicator.color = .red
        myActivityIndicator.hidesWhenStopped = true
       
    }
    
    // MARK: - Action Button
    @IBAction func buttonClickAction(_ sender: Any) {
        
        if buttonClick.backgroundColor == .white {
            buttonClick.backgroundColor = .green
        } else {
            buttonClick.backgroundColor = .white
        }
    }
    
    // MARK: Action PageControl
    
    @IBAction func myPageControlAction(_ sender: Any) {
        pickerLista.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        
        // cambiando tambien el titulo de boton
        let myStringButton = lista[myPageControl.currentPage]
        buttonClick.setTitle(myStringButton, for: .normal)
    }
    
    // MARK: Action Segemented Control
    @IBAction func segementAction(_ sender: Any) {
        pickerLista.selectRow(mySegmentControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myStringButton = lista[mySegmentControl.selectedSegmentIndex]
        buttonClick.setTitle(myStringButton, for: .normal)
        
    }
    
    // MARK: Action Slider
    
    @IBAction func sliderAction(_ sender: Any) {
        
        
        var progress: Float = 0
        switch mySlider.value {
        case 1..<2:
            pickerLista.selectRow(0, inComponent: 0, animated: true)
            
            // dando un valor al progress view
            progress = 0.2
        case 2..<3:
            pickerLista.selectRow(1, inComponent: 0, animated: true)
            progress = 0.4
        case 3..<4:
            pickerLista.selectRow(2, inComponent: 0, animated: true)
            progress = 0.6
        case 4..<5:
            pickerLista.selectRow(3 ,inComponent: 0, animated: true)
            progress = 0.8
       
        default:
            pickerLista.selectRow(4, inComponent: 0, animated: true)
            progress = 1
        }
        
        // MARK: - Action progress view
        myProgressView.progress = progress
    }
    
    
    // MARK: - Action Stepper
    
    @IBAction func stepperAction(_ sender: Any) {
        let value = mySteper.value
        mySlider.value = Float(value)
    }
    
    
    // MARK: - Action Switch
    @IBAction func switchAction(_ sender: Any) {
        if mySwitch.isOn {
            pickerLista.isHidden = true
            // MARK: - Action Activity Indicator
            myActivityIndicator.startAnimating()
        } else {
            pickerLista.isHidden = false
            myActivityIndicator.stopAnimating()
        }
    }
}

// MARK:  Extension PickerView
// creando una extension del propio view controller, con dos protocolos de picker view
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    // recordar que como son dos protocolos, hay que implementar las funciones si o si, en este caso estas don funciones son numberOfComponent y picker view
    
    // numero de componentes define las colmnas que se van a ver en el picker,
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // numero de filas que contendra nuestro picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // recordar que hay un -> por lo tanto hay que retornar
        return lista.count
    }
    
    // para mostrar los strings, la funcion es titleFor
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lista[row]
    }
    
    
    // recordar que dataSource es para cargar Datos, y Delegate es para interactura con la vista, en este caso fijarse siempre en el segundo parametro
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        buttonClick.setTitle(lista[row], for: .normal)
        
         // creando un evento para que tambien cambie nuestro pagecontrol
        myPageControl.currentPage = row
        
        // para el segmento contro
        mySegmentControl.selectedSegmentIndex = row
        
        
    }
   
    
    
}


// MARK: - Extension TextFiedl
extension ViewController: UITextFieldDelegate {
    // este funcion es para cerrar el teclado cuando se de en la tecla return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.resignFirstResponder()
    }
    
    // esta funcion es para realizar una accion una vez que se haya finalizado de ingresar
    func textFieldDidEndEditing(_ textField: UITextField) {
        buttonClick.setTitle(myTextField.text, for: .normal)
    }
}

