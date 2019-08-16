#!/usr/bin/env python3

import os
from xxpystuff.tools import Process
from .settings import Settings

class UserManager:

    def __init__(self):

        pass

    def addUser(self, name, passwd):

        fileName = Settings.the.getPasswordFileName()        
        
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

        fileName = Settings.the.getPasswordFileName()
        if not os.path.exists(fileName):
            return

        argList = ['-D']
        argList.append(fileName)
        argList.append(name)
        
        p = Process('htpasswd')
        p.start(argList)
