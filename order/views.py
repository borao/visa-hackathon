# Create your views here.
import requests
from datetime import timedelta, datetime
from django.db.models import Sum
from django.http import HttpResponse, JsonResponse
from rest_framework import viewsets
from .models import Order
from .serializers import OrderSerializer
from rest_framework.decorators import action
from django.http import HttpResponse
import requests
from collections import Counter
from django.db.models import Count
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
        qrCode = requests.get(url=requestUrl)
        return HttpResponse(qrCode.content, content_type="image/png")

    @action(detail=False, url_path='getLeaderboard/(?P<merchantID>[^/.]+)')
    def getLeaderboard(self, request, merchantID):
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
        total = float(self.queryset.filter(merchantID = merchantID).aggregate(Sum('giftAmount'))['giftAmount__sum'] or 0)
        return HttpResponse(total)

    # http://localhost:8000/orders/userImpact/1/
    @action(detail = False, url_path='userImpact/(?P<userID>[^/.]+)')
    def userImpact(self, request, userID):

        sevenDaysAgo = (datetime.now() - timedelta(days = 7)).date()
        numberGiftSentThisWeek = self.queryset.filter(senderID = userID).filter(date_ordered__gt=sevenDaysAgo).count()

        giftReceivedAggregatedThisWeek =  self.queryset.filter(receiverID = userID).filter(date_ordered__gt=sevenDaysAgo).aggregate(Sum('giftAmount'))
        AmountReceivedThisWeek =  float(giftReceivedAggregatedThisWeek['giftAmount__sum'] or 0)

        giftSentAggregated = self.queryset.filter(senderID = userID).aggregate(Sum('giftAmount'))
        amountGiftSent = float(giftSentAggregated['giftAmount__sum'] or 0)

        numberGiftSent = self.queryset.filter(senderID = userID).count()

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