from http.client import HTTPResponse

from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets
from .models import Order
from .serializers import  OrderSerializer
from rest_framework.decorators import action
from django.http import HttpResponse
import requests

QRCODE_API_ENDPOINT = 'https://api.qrserver.com/v1/create-qr-code/?size=250x250&data='

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    @action(detail = True, methods=['get'])
    def getQRCode(selfs, request, pk):
        requestUrl = QRCODE_API_ENDPOINT + pk
        qrCode = requests.get(url = requestUrl)
        return HttpResponse(qrCode.content, content_type="image/png")
