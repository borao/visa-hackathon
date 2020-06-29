"""informed_visit URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
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
import sys
sys.path.append("..")
from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from users import urls as userUrl
from order import urls as orderUrl
from merchant import urls as merchantUrl

router = DefaultRouter()

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', include(userUrl)),
    path('orders/', include(orderUrl)),
    path('merchants/', include(merchantUrl)),
    # TODO: seems like we need to handle profile page (dashboard) in the django's User
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))


]