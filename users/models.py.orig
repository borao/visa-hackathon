from django.contrib.auth.models import User
from django.db import models
from django.utils import timezone
<<<<<<< HEAD
from django.contrib.auth.models import User
from django.core.validators import MaxValueValidator, MinValueValidator

=======
>>>>>>> 251db3f2c03f86b78b2c59f65fd36bc14214f168


# Create your models here.
class Customer(models.Model):
    # a customer can only have one user,
    # and a user can only have one customer
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    street = models.CharField(max_length=100, blank=False)
    city = models.CharField(max_length=50, blank=False)
    state = models.CharField(max_length=50, blank=False)
    zipcode = models.CharField(max_length=10, blank=False)
    longtitude = models.CharField(max_length=100, blank=False)
    latitude = models.CharField(max_length=100, blank=False)
    phone_number = models.IntegerField()
    profilePic = models.ImageField(default='minion.jpg', upload_to='profile_pics')
    distance = models.IntegerField(default=50,
                                   validators=[
                                       MaxValueValidator(100),
                                       MinValueValidator(1)])

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





