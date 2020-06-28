from datetime import datetime, timedelta

from django.db import models

from merchant import models as merchant_model
from users import models as customer_model


# Create your models here.


class Order(models.Model):

    transactionID = models.AutoField(primary_key=True)
    redeemed = models.BooleanField(default=False)
    senderID = models.ForeignKey(customer_model.Customer, related_name="sender", on_delete=models.CASCADE, blank=False)
    receiverID = models.ForeignKey(customer_model.Customer, related_name="receiver", on_delete=models.CASCADE, blank=False)
    date_ordered = models.DateField(auto_now_add=True)
    expiration_date = models.DateField(auto_created=True, editable=False, default=  (datetime.now() + timedelta(days=14)).date())
    merchantID = models.ForeignKey(merchant_model.Merchant, on_delete=models.CASCADE, blank=False)
    giftAmount = models.DecimalField(blank=False, max_digits=10, decimal_places=2)
    message = models.TextField(max_length=300, blank=True)

    def __str__(self):
        return str(self.senderID) + " gifted " + str(self.giftAmount) + " to " + str(self.receiverID) + " for " + str(self.merchantID)

