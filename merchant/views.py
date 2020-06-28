from rest_framework import viewsets

from .serializers import *


# Create your views here.

class MerchantViewSet(viewsets.ModelViewSet):
    queryset = Merchant.objects.all()
    serializer_class = MerchantSerializer