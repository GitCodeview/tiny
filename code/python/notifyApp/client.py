"""
The common tkinter window code.
"""

import tkinter as tk # gui
import pynput as pt # mouse and keboard

class LogViewer:
  def __init__(self):
    self.window=tk.Tk()
    self.window.title("Logs Viewer")   #窗口标题
    self.window.geometry("512x512")  #窗口尺寸

  def run(self):
    self.window.mainloop()


if __name__ == "__main__":
    LogViewer().run()