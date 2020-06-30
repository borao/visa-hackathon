from typing import List

from rest_framework import viewsets

from rest_framework.decorators import action

from .serializers import *
from .merchant_locator_api.src.customizedMerchantLocator import MerchantLocator
from django.http import HttpResponse
from multiprocessing import Pool

# Create your views here.


class MerchantViewSet(viewsets.ModelViewSet):
    queryset = Merchant.objects.all()
    serializer_class = MerchantSerializer

    mcc = {"FAST_FOOD": '"5814"',  # FAST_FOOD
           "CLOTHING": '"5651", "5611", "5691", "5137"',  # CLOTHING
           "GROCERY": '"5422", "5499", "5411"',  # GROCERY
           "BEAUTY": '"5977", "7230", "7298"',  # BEAUTY
           "SPORTS": '"5940", "5941", "7032", "7911", "7933", "7932", "7941", "7992","7997"',
           "OTHERS": '"5992", "5193", "5192", "5199", "5200", "5211","5251", "5261"'}  # OTHERS
            # "BAKERIES": '"5462","5441","5451","5300"',  # BAKERIES

    def __mapCategoryToMCC(self, category):
        return self.mcc[category]

    def __allMcc(self):
        keyset = ""
        for key in self.mcc.values():
            keyset = keyset + key + ","

        return keyset[:-1]

    @action(detail=False,
            url_path='getMerchantByCategory/(?P<distance>[^/.]+)/(?P<merchantCategoryCode>[^/.]+)/(?P<merchantPostalCode>[^/.]+)')
    def getMerchantByCategory(self, request, distance, merchantCategoryCode, merchantPostalCode):
        """
        get merchange by category
        :param distance: distance from user's location
        :param category: merchant category
        :param zipcode: user's zipcode
        :return:
        """

        merchantCategoryCode = self.__mapCategoryToMCC(merchantCategoryCode)

        obj = MerchantLocator.MerchantLocator()
        p = Pool(5)
        queries = list(map(lambda x: (x, distance, merchantCategoryCode, merchantPostalCode), range(10)))
        result = p.starmap(obj.postSearch_by_Category, queries)
        resp = []
        for res in result:
            for r in res:
                value = r.get('merchantID')
                if Merchant.objects.filter(merchantID=value).exists():
                    resp.append(r)
        return HttpResponse(resp, content_type="application/json")

    @action(detail=False,
            url_path='getMerchantWithoutCategory/(?P<distance>[^/.]+)/(?P<merchantPostalCode>[^/.]+)')
    def getMerchantWithoutCategory(self, request, distance, merchantPostalCode):
        """
        get merchange by category
        :param distance: distance from user's location
        :param category: merchant category
        :param zipcode: user's zipcode
        :return:
        """

        merchantCategoryCode = self.__allMcc()

        obj = MerchantLocator.MerchantLocator()
        p = Pool(5)
        queries = list(map(lambda x: (x, distance, merchantCategoryCode, merchantPostalCode), range(10)))
        print(queries)
        result = p.starmap(obj.postSearch_by_Category, queries)
        resp = []
        for res in result:
            for r in res:
                value = r.get('merchantID')
                if Merchant.objects.filter(merchantID=value).exists():
                    resp.append(r)
        return HttpResponse(resp, content_type="application/json")



