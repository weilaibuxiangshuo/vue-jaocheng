#-*- coding:utf-8 -*-
#@Time：2020/2/14 001418:23
#@Author：Follow your heart
#@File：jwtComponent.py

import datetime,jwt
from django.conf import settings
from django.core.cache import cache
class BackendToken(object):
    @classmethod
    def SetToken(cls,request,user):
        dic = {
            'data': {
                "id": user.id,
                "username": user.username
            }
        }
        encoded = jwt.encode(dic, settings.SECRET_KEY, algorithm='HS256')
        encoded = encoded.decode('utf-8')
        return encoded

    @classmethod
    def GetToken(cls, token):
        token_decode = jwt.decode(token, settings.SECRET_KEY, algorithm='HS256')
        getData=token_decode.get("data").get("username").strip()
        if getData:
            return cache.get(getData)
        else:
            return None





