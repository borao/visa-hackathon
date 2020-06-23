from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from merchant import models as merchant_model


# Create your models here.
class Customer(models.Model):
    # a customer can only have one user,
    # and a user can only have one customer
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    username = models.CharField(max_length=100, null=True)
    first_name = models.CharField(max_length=50, null=True)
    last_name = models.CharField(max_length=50, null=True)
    email = models.CharField(max_length=200, null=True)
    home_address = models.CharField(max_length=200, null=True)
    phone_number = models.CharField(max_length=15, null=True)
    # userQR = models.ImageField(default='default_userQR.jpg', upload_to='userQR')
    profilePic = models.ImageField(default='minion.jpg', upload_to='profile_pics')

    def __str__(self):
        return self.username


class Order(models.Model):
    # class Amount(models.IntegerChoices):
    #     FIVE = 1
    #     TEN = 2
    #     FIFTEEN = 3
    #     TWENTY = 4
    #     TWENTY_FIVE = 5
    #     FIFTY = 6

    senderID = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
    receiverID = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
    date_ordered = models.DateTimeField(default=timezone.now)
    expiration_date = models.DateTimeField(default=timezone.now)
    transactionID = models.CharField(max_length=200, null=True)
    merchantID = models.ForeignKey(merchant_model.Merchant, on_delete=models.SET_NULL, blank=True, null=True)
    giftAmount = models.IntegerField(choices=Amount.choices, null=True)
    message = models.TextField()
    orderQR = models.ImageField(default='default_orderQR.jpg', upload_to='orderQR')

    def __str__(self):
        return str(self.id)


class Card(models.Model):
    cardID = models.IntegerField(primary_key=True, max_length=16)
    customerID = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
    expiration_date = models.DateTimeField(default=timezone.now)
    cvc = models.IntegerField(max_length=4)
    first_name = models.CharField(max_length=50, null=True)
    last_name = models.CharField(max_length=50, null=True)
    street = models.CharField(max_length=100, null=True)
    city = models.CharField(max_length=50, null=True)
    state = models.CharField(max_length=50, null=True)
    zipcode = models.CharField(max_length=5, null=True)

    def __str__(self):
        return str(self.cardID)


class Friendship(models.Model):
    friendA = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
    friendB = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)





