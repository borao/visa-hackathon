from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Merchant(models.Model):
    # class Category(models.IntegerChoices):
    #     FAST_FOOD = 1 # FAST FOOD 5814
    #     BAKERIES = 2  # BAKERIES 5462
    #     CLOTHING = 3 # GENERAL APPAREL 5651, 5611, 5691, 5137
    #     GROCERY = 4 # SUPERMARKET 5814, 5422, 5441, 5451, 5499, 5411
    #     BEAUTY = 5 # COSMETIC AND BEAUTY STORE 5977, 7230, 7298,
    #     OTHERS = 6 # FLORIST 5992, 5193 # COMPUTER AND ELECTRONICS 5732 5734 # SPORTS ENTERTAINMENT 7032, 7911, 7829, 7832, 7841

    merchantName = models.CharField(max_length=100, blank=False)
    category = models.CharField(max_length=50, default='OTHERS')
    # hours = models.CharField(max_length=100)
    merchantID = models.CharField(primary_key=True, max_length=200)
    # TODO: check how bank account works with Visa payment
    # bankAccount = models.CharField(max_length=200, blank=True)
    # TODO: include storeID


    def __str__(self):
        return str(self.merchantName)
