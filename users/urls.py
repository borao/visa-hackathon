from django.urls import path, include
from rest_framework import routers
from .views import *

router = routers.DefaultRouter()
router.register(r'customer', CustomerViewSet)
router.register(r'friendship', FriendShipViewSet)
router.register(r'card', CardViewSet)

urlpatterns = [
    path('', include(router.urls)),
]