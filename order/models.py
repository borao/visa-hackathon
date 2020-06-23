from django.db import models
from django.utils import timezone
from users import models as customer_model
from merchant import models as merchant_model
# Create your models here.


class Order(models.Model):

    senderID = models.ForeignKey(customer_model.Customer, on_delete=models.SET_NULL, blank=True, null=True)
    receiverID = models.ForeignKey(customer_model.Customer, on_delete=models.SET_NULL, blank=True, null=True)
    date_ordered = models.DateTimeField(default=timezone.now)
    expiration_date = models.DateTimeField(default=timezone.now)
    transactionID = models.CharField(max_length=200, null=True)
    merchantID = models.ForeignKey(merchant_model.Merchant, on_delete=models.SET_NULL, blank=True, null=True)
    giftAmount = models.FloatField()
    message = models.TextField()
    orderQR = models.ImageField(default='default_orderQR.jpg', upload_to='orderQR')

    def __str__(self):
        return str(self.id)
