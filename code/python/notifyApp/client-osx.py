"""
The mac osx client main app.

The client use to receive the notice messages and notify the users.
"""

import rumps
import subprocess
import os
import client as cw # the common tkinter window code

rumps.debug_mode(True) # debug mode

class LogViewer(rumps.Window):
    """
    Viewer sever today log.
    """
    def __init__(self):
        super(LogViewer, self).__init__(message='Log Text', title='Log Viewer', ok='Close', cancel=None, dimensions=(0, 0))
    
    def setLogText(self, logText):
        """
        Set Log Viwer text
        """
        self.message = logText

class Preferences(rumps.Window):
    """
    Preference setting window
    """
    def __init__(self):
        super(Preferences, self).__init__(message='Server IP and Port',title='Preference', default_text="192.168.0.66:8888", ok='Save', cancel="Close", dimensions=(250,24))
        

class FinanceStatus(rumps.App):
    """
    Main menu app
    """
    def __init__(self):
        super(FinanceStatus, self).__init__("FinanceStatus")
        self.menu = ["Preferences", "Check Server Status", "View Log"]
        self.serverLink = '192.168.0.66:8888'

    @rumps.clicked("Preferences")
    def prefs(self, _):
        """
        Set Server Info
        """
        self.preferences = Preferences()
        result = self.preferences.run()
        print(result.clicked)
        if result.clicked and self.serverLink != result.text:
            self.serverLink = result.text
        print(self.serverLink)

    # @rumps.clicked("Silly button")
    # def onoff(self, sender):
    #     sender.state = not sender.state

    @rumps.clicked("Check Server Status")
    def showServerStatus(self, _):
        rumps.notification("Server Status", "Normal", "Not Action! .....")

    @rumps.clicked("View Log")
    def runLogViewer(self, _):
        # TODO: Get log from server
        logText = ''
        logText +='[2019-09-03 12:00] Update the daily data from tushare, succeed some. \n'
        logText +='[2019-09-03 12:00] Failed list:\n'
        logText +='[2019-09-03 12:00] M0002, M003, M333, M0002, M003, M333, M0002, M003, M333, M0002, M003, M333\n '
        # show daily log
        self.logViewer = LogViewer()
        self.logViewer.setLogText(logText)
        self.logViewer.run()


if __name__ == "__main__":
    FinanceStatus().run()
    # cw.LogViewer().run()