from django.db import models


# Create your models here.


class Merchant(models.Model):
    class Category(models.IntegerChoices):
        COFFEE = 1
        FAST_FOOD = 2
        DESSERTS = 3
        CLOTHING = 4
        GROCERY = 5
        BEAUTY = 6
        OTHERS = 7

    merchantName = models.CharField(max_length=100, blank=False)
    category = models.IntegerField(choices=Category.choices, default=7)
    hours = models.CharField(max_length=100)
    merchantID = models.CharField(primary_key=True, max_length=200)
    # TODO: check how bank account works with Visa payment
    bankAccount = models.CharField(max_length=200, blank=True)

    def __str__(self):
        return str(self.merchantName)