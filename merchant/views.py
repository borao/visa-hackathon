from rest_framework import viewsets

from .serializers import *
from .merchant_locator_api.src.customizedMerchantLocator import MerchantLocator
from django.http import JsonResponse


# Create your views here.

class MerchantViewSet(viewsets.ModelViewSet):
    queryset = Merchant.objects.all()
    serializer_class = MerchantSerializer

    def mapCategoryToMCC(self, choice):
        choiceStr = str(choice)
        mcc = {"1": '"5451","5814"', # FAST_FOOD
               "2": '"5462"', # BAKERIES
               "3": '"5813"', # BAR
               "4": '"5651", "5611", "5691", "5137"', # CLOTHING
               "5": '"5814", "5422", "5441", "5499", "5411"', # GROCERY
               "6": '"5977", "7230", "7298"', # BEAUTY
               "7": '"5992", "5193", "7032", "7911", "7829", "7832", "7841"'} #OTHERS
        return mcc[choiceStr]

    def getMerchantByCategory(self, distance, category, zipcode):

        category = self.mapCategoryToMCC(category)

        merchant_by_category = MerchantLocator.MerchantLocator.postSearch_by_Category(distance=distance,
                                                                                      merchantCategoryCode=category,
                                                                                      zipcode=zipcode)
        for i in range(len(merchant_by_category)-1):
            print(merchant_by_category[i])
        return JsonResponse(merchant_by_category, safe=False)

    def getMerchantByName(self, distance, merchantName, longitude, latitude):

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
    MerchantViewSet(viewsets.ModelViewSet).getMerchantByCategory(50, 2, "95131")
