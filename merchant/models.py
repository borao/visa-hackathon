from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Merchant(models.Model):
    class Category(models.IntegerChoices):
        COFFEE = 1
        FAST_FOOD = 2
        DESSERTS = 3
        CLOTHING = 4
        GROCERY = 5
        BEAUTY = 6

    merchantName = models.CharField(max_length=100, null=True)
    category = models.IntegerField(choices=Category.choices, null=True)
    hours = models.CharField(max_length=100, null=True)
    merchantID = models.CharField(max_length=200, null=True)
    bankAccount = models.CharField(max_length=200, null=True)
