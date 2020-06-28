from django.shortcuts import render
from rest_framework import viewsets
from .models import *
from .serializers import *
from .merchant_locator_api.src.customizedMerchantLocator import MerchantLocator
from django.http import JsonResponse
from rest_framework.decorators import action


# Create your views here.

class CustomerViewSet(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer

    def mapCategoryToMCC(self, category):
        mcc = {"FAST_FOOD": '"5451","5814"',  # FAST_FOOD
               "BAKERIES": '"5462"',  # BAKERIES
               "CLOTHING": '"5651", "5611", "5691", "5137"',  # CLOTHING
               "GROCERY": '"5814", "5422", "5441", "5499", "5411"',  # GROCERY
               "BEAUTY": '"5977", "7230", "7298"',  # BEAUTY
               "OTHERS": '"5992", "5193", "7032", "7911", "7829", "7832", "7841"'}  # OTHERS
        return mcc[category]

    @action(detail=True, methods=['post'])
    def getMerchantByCategory(self, request):
        """
        get merchange by category
        :param distance: distance from user's location
        :param category: merchant category
        :param zipcode: user's zipcode
        :return:
        """
        # distance, category, zipcode
        requestData = request.data
        serializer = self.get_serializer(data=requestData)
        serializer.is_valid(raise_exception=True)

        categoryCode = self.mapCategoryToMCC(serializer.validated_data['merchantCategoryCode'])
        distance = serializer.validated_data['distance']
        zipcode = serializer.validated_data['merchantPostalCode']

        merchant_by_category = MerchantLocator.MerchantLocator.postSearch_by_Category(distance=distance,
                                                                                      merchantCategoryCode=categoryCode,
                                                                                      zipcode=zipcode)
        for i in range(len(merchant_by_category) - 1):
            print(merchant_by_category[i])
        return JsonResponse(merchant_by_category, safe=False)

    @action(detail=True, methods=['post'])
    def getMerchantByName(self, request):
        # distance, merchantName, longitude, latitude
        requestData = request.data
        serializer = self.get_serializer(data=requestData)
        serializer.is_valid(raise_exception=True)

        distance = serializer.validated_data['distance']
        merchantName = serializer.validated_data['merchantName']
        longitude = serializer.validated_data['longitude']
        latitude = serializer.validated_data['latitude']

        merchant_by_name = MerchantLocator.MerchantLocator.postSearch_by_Name(distance=distance,
                                                                              merchantName=merchantName,
                                                                              latitude=latitude,
                                                                              longitude=longitude)
        for i in range(len(merchant_by_name) - 1):
            print(merchant_by_name[i])
        return JsonResponse(merchant_by_name, safe=False)


class FriendShipViewSet(viewsets.ModelViewSet):
    queryset = Friendship.objects.all()
    serializer_class = FriendShipSerializer


class CardViewSet(viewsets.ModelViewSet):
    queryset = Card.objects.all()
    serializer_class = CardSerializer
