//
//  DrawingGestureRecognizer.swift
//  FrontNative
//
//  Created by 前島文香 on 2021/01/04.
//
import SwiftUI

protocol DrawingGestureRecognizerDelegate: class {
func gestureRecognizerBegan(_ location: CGPoint)
func gestureRecognizerMoved(_ location: CGPoint)
func gestureRecognizerEnded(_ location: CGPoint)
}

class DrawingGestureRecognizer: UIGestureRecognizer {
  weak var drawingDelegate: DrawingGestureRecognizerDelegate?
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("hello1")
    if let touch = touches.first,
    //touch.type == .pencil,
    let numberOfTouches = event?.allTouches?.count,
    numberOfTouches == 1 {
      state = .began
      let location = touch.location(in: self.view)
        print("hello3")
      drawingDelegate?.gestureRecognizerBegan(location)
    } else {
      state = .failed
    }
  }
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    state = .changed
    guard let location = touches.first?.location(in: self.view) else { return }
    drawingDelegate?.gestureRecognizerMoved(location)
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let location = touches.first?.location(in: self.view) else  {
      state = .ended
      return
    }
    drawingDelegate?.gestureRecognizerEnded(location)
    state = .ended
  }
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
    state = .failed
  }
}


