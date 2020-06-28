from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action

from .models import *
from .serializers import *
from .merchant_locator_api.src.customizedMerchantLocator import MerchantLocator
from django.http import JsonResponse

# Create your views here.


class MerchantViewSet(viewsets.ModelViewSet):
    queryset = Merchant.objects.all()
    serializer_class = MerchantSerializer

    def mapCategoryToMCC(self, category):
        mcc = {"FAST_FOOD": '"5451","5814"', # FAST_FOOD
               "BAKERIES": '"5462"', # BAKERIES
               "CLOTHING": '"5651", "5611", "5691", "5137"', # CLOTHING
               "GROCERY": '"5814", "5422", "5441", "5499", "5411"', # GROCERY
               "BEAUTY": '"5977", "7230", "7298"', # BEAUTY
               "OTHERS": '"5992", "5193", "7032", "7911", "7829", "7832", "7841"'} #OTHERS
        return mcc[category]

    @action(detail=True, methods=['post'], name='get-merchant-by-category')
    def getMerchantByCategory(self, request, distance, category, zipcode):
        """
        get merchange by category
        :param distance: distance from user's location
        :param category: merchant category
        :param zipcode: user's zipcode
        :return:
        """

        categoryCode = self.mapCategoryToMCC(category)

        merchant_by_category = MerchantLocator.MerchantLocator.postSearch_by_Category(distance=distance,
                                                                                      merchantCategoryCode=categoryCode,
                                                                                      zipcode=zipcode)
        for i in range(len(merchant_by_category)-1):
            print(merchant_by_category[i])
        return JsonResponse(merchant_by_category, safe=False)

    @action(detail=True, methods=['post'], name='get-merchant-by-name')
    def getMerchantByName(self, request, distance, merchantName, longitude, latitude):

        merchant_by_name = MerchantLocator.MerchantLocator.postSearch_by_Name(distance=distance,
                                                                              merchantName=merchantName,
                                                                              latitude=latitude,
                                                                              longitude=longitude)
        for i in range(len(merchant_by_name)-1):
            print(merchant_by_name[i])
        return JsonResponse(merchant_by_name, safe=False)


if __name__ == '__main__':

    # distance = 50
    # zipcode = "95131"
    # merchantName = "starbucks"
    # longitude = "-121.929163"
    # latitude = "37.363922"
    # choice = 1
    MerchantViewSet(viewsets.ModelViewSet).getMerchantByCategory(50, "FAST_FOOD", "95131")
    