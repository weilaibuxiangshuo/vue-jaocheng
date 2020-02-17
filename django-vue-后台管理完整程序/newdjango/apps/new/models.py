from django.db import models
from django.contrib.auth.models import AbstractUser
from django.conf import settings

class NewUser(AbstractUser):
    """
    role:与角色关联
    """
    role=models.ForeignKey(to='Roles',related_name='user_role',on_delete=models.CASCADE,blank=True,null=True)
    class Meta:
        db_table="newuser"


class Roles(models.Model):
    """
    title:名称
    """
    title=models.CharField(max_length=128,blank=True,null=True)
    class Meta:
        db_table="roles"


class Options(models.Model):
    """
    title:名称
    url:请求路径
    method:请求方式
    menu:与菜单关联
    role:与角色关联
    """
    title=models.CharField(max_length=128,blank=True,null=True)
    url=models.CharField(max_length=512,blank=True,null=True)
    method = models.CharField(max_length=56, blank=True, null=True)
    menu=models.ForeignKey(to="Menus",related_name="option_menu",on_delete=models.CASCADE,blank=True,null=True)
    role=models.ManyToManyField(to="Roles",related_name="option_role",blank=True)

    class Meta:
        db_table="options"


class Menus(models.Model):
    """
     title:名称
     url:请求路径
     icon:图标
     order:顺序
     menuself:内键关联
     """
    title=models.CharField(max_length=128,blank=True,null=True)
    url=models.CharField(max_length=512,blank=True,null=True)
    icon=models.CharField(max_length=56,blank=True,null=True)
    order=models.CharField(max_length=56,blank=True,null=True)
    menuself=models.ForeignKey(to="self",related_name="menu_self",on_delete=models.CASCADE,blank=True,null=True)

    class Meta:
        db_table="menus"







