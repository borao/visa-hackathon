from django.urls import path, include
from rest_framework import routers

from .views import *

router = routers.DefaultRouter()
router.register(r'program', ProgramViewSet)
router.register(r'enrollment', EnrollmentViewSet)

urlpatterns = [
    path('', include(router.urls)),
]