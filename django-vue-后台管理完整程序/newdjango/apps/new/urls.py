"""newvue URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.views.generic.base import TemplateView
from django.urls import path,re_path
from rest_framework_jwt.views import obtain_jwt_token
from .views import *
app_name='new'


urlpatterns = [
    re_path(r'login/$',Login.as_view(),name="login"),
    re_path(r'index/router/$',Index.as_view(),name="index"),
    re_path(r'users/menus/\w+/$',MenusApi.as_view(),name="menusapi"),
    re_path(r'users/menus/\w+/(\d+)/(\d+)/$',MenusDataApi.as_view(),name="menusdataapi"),
    re_path(r'users/controls/\w+/$',ControlsApi.as_view(),name="controlsapi"),
    re_path(r'users/controls/\w+/(\d+)/(\d+)/$',ControlDataApi.as_view(),name="controldataapi"),
    re_path(r'users/roles/\w+/$',RolesApi.as_view(),name="rolesapi"),
    re_path(r'users/roles/\w+/(\d+)/(\d+)/$',RoleDataApi.as_view(),name="roledataapi"),
    re_path(r'users/persons/\w+/$',PersonApi.as_view(),name="personapi"),
    re_path(r'users/persons/\w+/(\d+)/(\d+)/$',PersonDataApi.as_view(),name="persondataapi"),
    re_path(r'logout/', Logout.as_view(), name="logout"),
    path('', TemplateView.as_view(template_name="index.html")),
]
