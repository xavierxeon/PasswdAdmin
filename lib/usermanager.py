#!/usr/bin/env python3

import os
from xxpystuff.tools import Process

class UserManager:

    def __init__(self, settings):

        self._settings = settings

    def addUser(self, name, passwd):

        fileName = self._settings.getPasswordFileName()        
        
        argList = ['-b']
        if not os.path.exists(fileName):
            argList.append('-c')
        else:
            self.removeUser(name) # to update passwd
        argList.append(fileName)
        argList.append(name)
        argList.append(passwd)            
        
        p = Process('htpasswd')
        p.start(argList)
        
    def removeUser(self, name):

        fileName = self._settings.getPasswordFileName()
        if not os.path.exists(fileName):
            return

        argList = ['-D']
        argList.append(fileName)
        argList.append(name)
        
        p = Process('htpasswd')
        p.start(argList)
