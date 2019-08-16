#!/usr/bin/env python3

import os, sys, signal

# pylint: disable=no-name-in-module
from PySide2.QtCore import QTimer
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
# pylint: disable=no-name-in-module

from xxpystuff.tools import JSONSettings

from ..settings import Settings
from .usermodel import UserModel

def signit_handler(*args):

    QGuiApplication.quit()

def startGui():

    settings = Settings()
    try:
        settings.load()
    except JSONSettings.SettingsError as e:
        print(e)
        quit()

    app = QGuiApplication([])
    app.setOrganizationName('Schweinesystem')
    app.setOrganizationDomain('schweinesystem.eu')
    app.setApplicationName('PasswdAdmin')
    
    signal.signal(signal.SIGINT, signit_handler)
    timer = QTimer()
    timer.start(500)  # You may change this if you wish.
    timer.timeout.connect(lambda: None)  # Let the interpreter run each 500 ms.

    engine = QQmlApplicationEngine()

    usermodel = UserModel(settings)

    context = engine.rootContext()    
    context.setContextProperty('userModel', usermodel)

    thisFile = os.path.realpath(__file__)
    thisDir = os.path.dirname(thisFile)
    engine.load(thisDir + '/qml/MainWidget.qml')
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())

if __name__ == '__main__':
    startGui()   