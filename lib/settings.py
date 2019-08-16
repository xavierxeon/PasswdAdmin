#!/usr/bin/env python3

import os, json
from xxpystuff.tools import Console, JSONSettings

class Settings(JSONSettings):

    the = None

    _fileName = 'passwdadmin.json'
    _template = {
        'pwd_file': ''
    }

    def __init__(self):

        JSONSettings.__init__(self, self._fileName, self._template)
        Settings.the = self

    def load(self):

        super().load()       

        if not self.data['pwd_file']:
            self._abort('entry "pwd_file" is empty')

    def getPasswordFileName(self):

        name = self.data['pwd_file']
        return name
