# Create your views here.
import requests
from django.http import HttpResponse, JsonResponse
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
    def getQRCode(self, request, pk):
        requestUrl = QRCODE_API_ENDPOINT + pk
        qrCode = requests.get(url = requestUrl)
        return HttpResponse(qrCode.content, content_type="image/png")

    @action(detail=False, methods=['post'])
    def purchaseGift(self, request):
        requestData = request.data
        serializer = self.get_serializer(data = requestData)
        serializer.is_valid(raise_exception=True)

        response = chargeCreditCard(serializer.validated_data['giftAmount'])
        responseResultCode = response.messages.resultCode
        serializer.save()
        return HttpResponse(responseResultCode)

    # call this by adding id into the url like http://localhost:8000/orders/giftSentTo/2
    @action(detail=False, url_path='giftSentTo/(?P<receiverID>[^/.]+)')
    def giftSentTo(self, request, receiverID):
        searchResult = self.queryset.filter(receiverID = receiverID).values()
        return HttpResponse(searchResult, content_type="application/json")

    @action(detail = False, url_path='giftSentBy/(?P<senderID>[^/.]+)')
    def giftSentBy(self, request, senderID):
        searchResult = self.queryset.filter(senderID = senderID).values()
        return HttpResponse(searchResult, content_type="application/json")

    # to redeem the gift, use patch method on detail view
    # {
    #     "redeemed": true
    # }
