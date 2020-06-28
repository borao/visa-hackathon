from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action

from .models import *
from .serializers import *
from .merchant_locator_api.src.customizedMerchantLocator import MerchantLocator
from django.http import HttpResponse, JsonResponse
from multiprocessing import Pool


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

    @action(detail=False, url_path='getMerchantByCategory/(?P<distance>[^/.]+)/(?P<merchantCategoryCode>[^/.]+)/(?P<merchantPostalCode>[^/.]+)')
    def getMerchantByCategory(self, request, distance, merchantCategoryCode, merchantPostalCode):
        """
        get merchange by category
        :param distance: distance from user's location
        :param category: merchant category
        :param zipcode: user's zipcode
        :return:
        """

        merchantCategoryCode = self.mapCategoryToMCC(merchantCategoryCode)

        obj = MerchantLocator.MerchantLocator()
        p = Pool(5)
        queries = list(map(lambda x: (x, distance, merchantCategoryCode, merchantPostalCode), range(10)))
        print(queries)
        result = p.starmap(obj.postSearch_by_Category, queries)
        print(result)
        return HttpResponse(result, content_type="application/json")


    @action(detail=True, methods=['post'])
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
    