from http.client import HTTPResponse

from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets
from .models import Order
from .serializers import OrderSerializer
from rest_framework.decorators import action
from django.http import HttpResponse
import requests
from collections import Counter
from django.db.models import Count

QRCODE_API_ENDPOINT = 'https://api.qrserver.com/v1/create-qr-code/?size=250x250&data='


class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    @action(detail=True, methods=['get'])
    def getQRCode(selfs, request, pk):
        requestUrl = QRCODE_API_ENDPOINT + pk
        qrCode = requests.get(url=requestUrl)
        return HttpResponse(qrCode.content, content_type="image/png")

    @action(detail=True, methods=['get'])
    def getLeaderboard(self, request, pk):
        # TODO Accept merchant as a parameter - using dummy merchant for now
        merchantID = "12"
        orders = Order.objects.values_list('merchantID_id', 'senderID_id')
        gifts = Counter()
        for merchant, sender in orders:
            if merchant == merchantID:
                if sender in gifts:
                    gifts[sender] += 1
                else:
                    gifts[sender] = 1
        print(gifts.most_common())
        # Returns a list of tuples with the first element in the tuple
        # being the userID and the second element being the number of times they've donated
        return HttpResponse(gifts.most_common())
