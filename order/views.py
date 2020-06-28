# Create your views here.
import requests
from django.http import HttpResponse
from rest_framework import viewsets
from rest_framework.decorators import action

from .anet import chargeCreditCard
from .models import Order
from .serializers import OrderSerializer

QRCODE_API_ENDPOINT = 'https://api.qrserver.com/v1/create-qr-code/?size=250x250&data='

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

    @action(detail = True, methods=['get'])
    def getQRCode(selfs, request, pk):
        requestUrl = QRCODE_API_ENDPOINT + pk
        qrCode = requests.get(url = requestUrl)
        return HttpResponse(qrCode.content, content_type="image/png")

    @action(detail=False, methods=['post'])
    def purchaseGift(selfs, request):
        requestData = request.data
        serializer = selfs.get_serializer(data = requestData)
        serializer.is_valid(raise_exception=True)

        response = chargeCreditCard(serializer.validated_data['giftAmount'])
        responseResultCode = response.messages.resultCode
        serializer.save()
        return HttpResponse(responseResultCode)


    # to redeem the gift, use patch method on detail view
    # {
    #     "redeemed": true
    # }

