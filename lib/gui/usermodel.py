#!/user/bin/env python3

import os

from PySide6.QtCore import Qt, QByteArray, QAbstractListModel, Slot


from ..settings import Settings
from ..usermanager import UserManager


class UserModel(QAbstractListModel):

   RoleName = Qt.UserRole + 1

   def __init__(self, settings):

      QAbstractListModel.__init__(self)
      self.settings = settings

      self._nameList = list()
      self.load()

   def roleNames(self):

      roles = {
          UserModel.RoleName: QByteArray(b'name')
      }

      return roles

   def rowCount(self, index):

      rowCount = len(self._nameList)
      return rowCount

   def data(self, index, role):

      if not index.isValid():
         return None

      row = index.row()
      if row >= len(self._nameList):
         return None

      if role == UserModel.RoleName:
         return self._nameList[row]

      return None

   def load(self):

      self.beginResetModel()
      self._nameList.clear()

      fileName = Settings.the.getPasswordFileName()
      if not fileName or not os.path.exists(fileName):
         self.endResetModel()
         return

      with open(fileName, 'r') as infile:
         for line in infile:
            line = line.strip()
            if not line:
               continue
            index = line.index(':')
            name = line[: index]
            self._nameList.append(name)

      self._nameList.sort()
      self.endResetModel()

   @Slot(int, result=str)
   def getName(self, row):

      if row >= len(self._nameList):
         return None

      return self._nameList[row]

   @Slot(str, str, result=None)
   def addUser(self, name, passwd):

      userManager = UserManager()
      userManager.addUser(name, passwd)

      self.load()

   @Slot(str, result=None)
   def removeUser(self, name):

      userManager = UserManager()
      userManager.removeUser(name)

      self.load()
