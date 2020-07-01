from django.contrib.auth.models import User
from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from django.core.validators import MaxValueValidator, MinValueValidator



# Create your models here.
class Customer(models.Model):
    # a customer can only have one user,
    # and a user can only have one customer
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    street = models.CharField(max_length=100, blank=False, default='900 Metro Center Blvd')
    city = models.CharField(max_length=50, blank=False, default='Foster City')
    state = models.CharField(max_length=50, blank=False, default='CA')
    zipcode = models.CharField(max_length=10, blank=False, default='zipcode_string')
    longitude = models.CharField(max_length=100, blank=False, default='-122.2763649')
    latitude = models.CharField(max_length=100, blank=False, default='37.5592521')
    phone_number = models.IntegerField(blank=True)
    profilePic = models.ImageField(default='minion.jpeg', upload_to='profile_pics')


    def __str__(self):
        return self.user.username


class Card(models.Model):
    cardID = models.IntegerField(primary_key=True, blank=False)
    customerID = models.ForeignKey(Customer, on_delete=models.SET_NULL, null=True)
    expiration_date = models.DateTimeField(default=timezone.now, blank=False)
    cvv = models.PositiveSmallIntegerField(blank=False, default='')
    first_name = models.CharField(max_length=50, blank=False)
    last_name = models.CharField(max_length=50, blank=False)
    street = models.CharField(max_length=100, blank=False)
    city = models.CharField(max_length=50, blank=False)
    state = models.CharField(max_length=50, blank=False)
    zipcode = models.CharField(max_length=10, blank=False)

    def __str__(self):
        return str(self.cardID)


class Friendship(models.Model):
    friendA = models.ForeignKey(Customer, related_name="friendA", on_delete=models.CASCADE)
    friendB = models.ForeignKey(Customer, related_name="friendB", on_delete=models.CASCADE)

    def __str__(self):
        return str(self.friendA) +" and " + str(self.friendB)





