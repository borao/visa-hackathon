from django.db import models
from django.utils import timezone
from users import models as customer_model
from merchant import models as merchant_model
# Create your models here.


class Order(models.Model):

    senderID = models.ForeignKey(customer_model.Customer, related_name="sender", on_delete=models.CASCADE, blank=False)
    receiverID = models.ForeignKey(customer_model.Customer, related_name="receiver", on_delete=models.CASCADE, blank=False)
    date_ordered = models.DateTimeField(default=timezone.now)
    expiration_date = models.DateTimeField(default=timezone.now)
    transactionID = models.CharField(primary_key=True, max_length=200)
    merchantID = models.ForeignKey(merchant_model.Merchant, on_delete=models.CASCADE, blank=False)
    giftAmount = models.DecimalField(blank=False, max_digits=10, decimal_places=2)
    message = models.TextField(max_length=300)

    def __str__(self):
        return str(self.senderID) + " gifted " + str(self.giftAmount) + " to " + str(self.receiverID) + " for " + str(self.merchantID)

