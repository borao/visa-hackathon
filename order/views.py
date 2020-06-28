# Create your views here.
import requests
from datetime import timedelta, datetime
from django.db.models import Sum
from django.http import HttpResponse, JsonResponse
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.utils import json

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

    # http://localhost:8000/orders/giftSentTo/2
    @action(detail=False, url_path='giftSentTo/(?P<receiverID>[^/.]+)')
    def giftSentTo(self, request, receiverID):
        searchResult = self.queryset.filter(receiverID = receiverID).values()
        return HttpResponse(searchResult, content_type="application/json")

    # http://localhost:8000/orders/giftSentBy/1
    @action(detail = False, url_path='giftSentBy/(?P<senderID>[^/.]+)')
    def giftSentBy(self, request, senderID):
        searchResult = self.queryset.filter(senderID = senderID).values()
        return HttpResponse(searchResult, content_type="application/json")

    # http://localhost:8000/orders/giftRelatedTo/1/
    @action(detail = False, url_path='giftRelatedTo/(?P<userID>[^/.]+)')
    def giftRelatedTo(self, request, userID):
        searchResult = (self.queryset.filter(senderID = userID) | self.queryset.filter(receiverID = userID)).values()
        return HttpResponse(searchResult, content_type="application/json")

    # http://localhost:8000/orders/giftForMerchant/1111111/
    @action(detail = False, url_path='giftForMerchant/(?P<merchantID>[^/.]+)')
    def giftForMerchant(self, request, merchantID):
        searchResult = self.queryset.filter(merchantID = merchantID).values()
        return HttpResponse(searchResult, content_type="application/json")

    # http://localhost:8000/orders/totalGiftAmountByMerchant/1111111/
    @action(detail = False, url_path='totalGiftAmountByMerchant/(?P<merchantID>[^/.]+)')
    def totalGiftAmountByMerchant(self, request, merchantID):
        total = self.queryset.filter(merchantID = merchantID).aggregate(Sum('giftAmount'))
        return HttpResponse(float(total['giftAmount__sum']))

    # http://localhost:8000/orders/userImpact/1/
    @action(detail = False, url_path='userImpact/(?P<userID>[^/.]+)')
    def userImpact(self, request, userID):

        sevenDaysAgo = (datetime.now() - timedelta(days = 7)).date()
        numberGiftSentThisWeek = len(self.queryset.filter(senderID = userID).filter(date_ordered__gt=sevenDaysAgo))

        giftReceivedAggregatedThisWeek =  self.queryset.filter(receiverID = userID).filter(date_ordered__gt=sevenDaysAgo).aggregate(Sum('giftAmount'))
        AmountReceivedThisWeek =  float(giftReceivedAggregatedThisWeek['giftAmount__sum'])

        giftSentAggregated = self.queryset.filter(senderID = userID).aggregate(Sum('giftAmount'))
        amountGiftSent = float(giftSentAggregated['giftAmount__sum'])

        numberGiftSent = len(self.queryset.filter(senderID = userID))

        payload = {'numberGiftSentThisWeek': numberGiftSentThisWeek,
                   'AmountReceivedThisWeek': AmountReceivedThisWeek,
                   'amountGiftSent': amountGiftSent,
                   'numberGiftSent': numberGiftSent
                   }

        return HttpResponse(json.dumps(payload))

    # to redeem the gift, use patch method on detail view
    # {
    #     "redeemed": true
    # }
