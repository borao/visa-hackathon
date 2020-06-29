from django.db import models

from merchant import models as merchant_model
from users import models as customer_model


# Create your models here.


class Program(models.Model):
    # merchantID = models.ForeignKey(merchant_model.Merchant, on_delete=models.CASCADE, blank=False)
    programID = models.AutoField(primary_key=True)
    programName = models.CharField(max_length=50, blank=False)
    description = models.TextField()
    goal = models.IntegerField(default=10)

    def __str__(self):
        return str(self.programName)

class UserToMerchant(models.Model):
    userID = models.ForeignKey(customer_model.Customer, on_delete=models.CASCADE, blank=False)
    merchantID = models.ForeignKey(merchant_model.Merchant, on_delete=models.CASCADE, blank=False)
    curProgress = models.IntegerField(default = 0)
    programID = models.ForeignKey(Program, on_delete=models.CASCADE)

    def __str__(self):
        return "user " + str(self.userID) + " is enrolled in merchant " + str(self.merchantID) + "'s " + str(self.programID)
