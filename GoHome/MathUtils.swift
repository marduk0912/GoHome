//
//  MathUtils.swift
//  GoHome
//
//  Created by Fernando on 13/04/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import Foundation
import CoreGraphics

// funcion que dado dos puntos devuelve un nuevo punto como suma de estos

func + (firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
    return CGPoint(x: firstPoint.x + secondPoint.x, y: firstPoint.y + secondPoint.y)
}

// funcion que dado dos numeros le suma al primero el segundo y lo devuelve como parametro

func += ( firstPoint:inout CGPoint, secondPoint:CGPoint) {
    firstPoint = firstPoint + secondPoint
}

// funcion que dado dos puntos devuelve un nuevo punto como resta de estos

func - (firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
    return CGPoint(x: firstPoint.x - secondPoint.x, y: firstPoint.y - secondPoint.y)
}

// funcion que dado dos numeros le resta al primero el segundo y lo devuelve como parametro

func -= ( firstPoint:inout CGPoint, secondPoint:CGPoint) {
    firstPoint = firstPoint - secondPoint
}

// funcion que dado dos puntos devuelve un nuevo punto como multiplicacion de estos

func * (firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
    return CGPoint(x: firstPoint.x * secondPoint.x, y: firstPoint.y * secondPoint.y)
}

// funcion que dado dos numeros multiplica al primero el segundo y lo devuelve como parametro

func *= ( firstPoint:inout CGPoint, secondPoint:CGPoint) {
    firstPoint = firstPoint * secondPoint
}

// funcion que dado un punto y un scalar, multiplica cada coordenada por el scalar

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

// funcion que dado un punto lo multiplica por un scalar y lo devuelve como parametro

func *= ( point:inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

// funcion que dado dos puntos devuelve un nuevo punto como division de estos

func / (firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
    return CGPoint(x: firstPoint.x / secondPoint.x, y: firstPoint.y / secondPoint.y)
}

// funcion que dado dos numeros divide al primero el segundo y lo devuelve como parametro

func /= ( firstPoint:inout CGPoint, secondPoint:CGPoint) {
    firstPoint = firstPoint / secondPoint
}

// funcion que dado un punto y un scalar, divide cada coordenada por el scalar

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

// funcion que dado un punto lo divide por un scalar y lo devuelve como parametro

func /= ( point:inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}



// solo se ejecutara si la app corre en 32 bits

#if !(arch(x86_64) || arch(arm64))
    func atan2(y: CGFloat, x: CGFloat) -> CGFloat{
        return CGFloat(atan2(Float(y), Float(x)))
    }

func sqrt(a:CGFloat) ->CGFloat {
    return CGFloat(sqrtf(a))
}
#endif

extension CGPoint {
    // calcula la longitud del punto usando el teorema de pitagoras
    func longitud() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    // normaliza el vector para que tenga longitud 1
    func normaliza() -> CGPoint {
        return self / longitud()
    }
    // halla el angulo que forma el punto con la horizontal
    var angle: CGFloat {
        return atan2(y, x)
    }
}

let π = CGFloat(Double.pi)


// Gira al policia de modo que tenga que rotar lo menos posible
func shorterAngleBetween(angle1:CGFloat, angle2:CGFloat) -> CGFloat {
    let twoπ = 2.0 * π
    var angle = (angle2 - angle1).truncatingRemainder(dividingBy: twoπ)
    if angle >= π {
        angle -= twoπ
    }
    if angle <= -π {
        angle += twoπ
    }
    // Despues de este fragmento, seguro que el angulo se encuentra entre -π y π, por lo tanto sabra hacia donde debe rotar con menor diferecia con respecto a su posicion original
    return angle
}

extension CGFloat {
    func signo() -> CGFloat {
        return (self <= 0) ? 1.0 : -1.0
    }
}
