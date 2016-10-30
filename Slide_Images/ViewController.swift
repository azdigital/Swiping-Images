//
//  ViewController.swift
//  Slide_Images
//
//  Created by Andrew on 2016-10-29.
//  Copyright © 2016 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cView = UIView() // это типа подкладка которая будет равна нашему всему экрану
    let edgeView = UIView() // выдвигающееся меню
    
    let firstImage = UIImageView() // подложка для фото №1
    let secondImage = UIImageView() // подложка для фото №2
    let thirdImage = UIImageView() // подложка для фото №3
    
    let closeEdgeView = UITapGestureRecognizer() // по тапке мы закроем нашу менюшку
    let openEdgeView = UIScreenEdgePanGestureRecognizer() // по еджпан (свайп с края) мы вытянем менюшку
    
    let swipeToSec = UISwipeGestureRecognizer() // свайп с первого на второй
    let swipeToThird = UISwipeGestureRecognizer() // свайп со второго на третий
    let swipeFromSec = UISwipeGestureRecognizer() // свайп обратно со второго на первый
    let swipeFromThird = UISwipeGestureRecognizer() // свайп обратно с третьего на второй
    
    //let swipeGesture = UISwipeGestureRecognizer() // универсальный свайп
    
    //var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        closeEdgeView.addTarget(self, action: #selector(tapEdgeViewControll)) // что делаем когда происходит тап закрытия менюшки
        openEdgeView.addTarget(self, action: #selector(swipeEdgeViewControll)) // что делаем когда нужно открыть менюшку
        
        /////// ПРИКРУЧИВАЕМ СВАЙПЫ
        
        swipeToSec.addTarget(self, action: #selector(toSecond)) // что делаем когда происходит свайп на вторую картинку
        swipeToThird.addTarget(self, action: #selector(toThird)) // что делаем когда происходит свайп на третью картинку
        swipeFromSec.addTarget(self, action: #selector(fromSecond)) // что делаем когда происходит свайп СО второй картинки на 1ю
        swipeFromThird.addTarget(self, action: #selector(fromThird)) // что делаем когда происходит свайп С третьей картинки на 2ю
 
        
        // swipeGesture.addTarget(self, action: #selector(imageSwipe))
 
        
        // Направления свайпов
        swipeToSec.direction = .left
        swipeToThird.direction = .left
        swipeFromThird.direction = .right
        swipeFromSec.direction = .right
        openEdgeView.edges = .left
        
        
        // РАЗМЕРЫ ВСЕХ ЭЛЕМЕНТОВ
        cView.frame = view.frame
        firstImage.frame = CGRect(x: 40, y: 40, width: view.frame.width - 80, height: view.frame.height - 80)
        secondImage.frame = firstImage.frame
        thirdImage.frame = firstImage.frame
        edgeView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - view.bounds.width/3, height: view.frame.height)
        
        
        // ПРЯЧЕМ ВТОРУЮ И ТРЕТЬЮ КАРТИНКУ
        secondImage.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        thirdImage.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        
        // ВЫСТАВЛЯЕМ ЦВЕТА и прозрачность ВСЕМ ЭЛЕМЕНТАМ
        edgeView.backgroundColor = UIColor.brown
        edgeView.alpha = 0.8
        
        firstImage.backgroundColor = UIColor.black
        secondImage.backgroundColor = UIColor.cyan
        thirdImage.backgroundColor = UIColor.orange
        
        // РАЗРЕШАЕМ СВАЙПАТЬ ПО ИМЕЙДЖВЬЮ
        firstImage.isUserInteractionEnabled = true
        secondImage.isUserInteractionEnabled = true
        thirdImage.isUserInteractionEnabled = true
        
        // ДОБАВЛЯЕМ ВСЕ СОБЫТИЯ И ЭЛЕМЕНТЫ НА ВЬЮ
        // вью:
        view.addSubview(cView)
        cView.addSubview(firstImage)
        cView.addSubview(secondImage)
        cView.addSubview(thirdImage)
        view.addSubview(edgeView)
        
        // события:
        cView.addGestureRecognizer(closeEdgeView)
        cView.addGestureRecognizer(openEdgeView)
        firstImage.addGestureRecognizer(swipeToSec)
        secondImage.addGestureRecognizer(swipeToThird)
        secondImage.addGestureRecognizer(swipeFromSec)
        thirdImage.addGestureRecognizer(swipeFromThird)
        
        
        
    }
    
    // прячем менюшку
    func tapEdgeViewControll(sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.edgeView.transform = CGAffineTransform(translationX: -self.edgeView.frame.width, y: 0)
        })
        
    }
    
    // показываем менюшку
    func swipeEdgeViewControll(sender: UIScreenEdgePanGestureRecognizer) {
        if (sender.state == .ended) {
            UIView.animate(withDuration: 0.3, animations: {
                self.edgeView.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
        
        
    }
    
 
    
    
    //свайпаем на вторую картинку
    func toSecond(sender:UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.3) {
        self.firstImage.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        self.secondImage.transform = CGAffineTransform(translationX: 0, y: 0)
        }}
    
    // свайпаем на третью картинку
    func toThird(sender:UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3) { 
            self.secondImage.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            self.thirdImage.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    // свайпаем обратно на 1ю картинку со второй
    func fromSecond(sender:UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3) { 
            self.firstImage.transform = CGAffineTransform(translationX: 0, y: 0)
            self.secondImage.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
        }
    }
    
    // свайпаем обратно с 3й на вторую картинку
    func fromThird(sender:UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3) { 
            self.secondImage.transform = CGAffineTransform(translationX: 0, y: 0)
            self.thirdImage.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
        }
    }
    
 
    
    
    /*
    func imageSwipe(sender:UISwipeGestureRecognizer) {
        if pageNumber == 1 {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                UIView.animate(withDuration: 0.3) {
                    self.firstImage.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                    self.secondImage.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.pageNumber = 2
                }
            case UISwipeGestureRecognizerDirection.left:
            print("end of list")
            default:
                break
            }
            
        } else if pageNumber == 2 {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                UIView.animate(withDuration: 0.3) {
                    self.secondImage.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                    self.thirdImage.transform = CGAffineTransform(translationX: 0, y: 0)}
                    self.pageNumber = 3
            case UISwipeGestureRecognizerDirection.left:
                UIView.animate(withDuration: 0.3) {
                    self.firstImage.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.secondImage.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)}
                    self.pageNumber = 1
            default:
                break
           
            }}
            else if pageNumber == 3 {
            switch self.swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("end of list")
            case UISwipeGestureRecognizerDirection.left:
                UIView.animate(withDuration: 0.3) {
                    self.secondImage.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.thirdImage.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
                    self.pageNumber = 2
                }
            default:
                break
        
            }
            
        }
        
        
        }
 */
 }
    




