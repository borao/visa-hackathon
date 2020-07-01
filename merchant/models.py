from django.db import models
# Create your models here.


class Merchant(models.Model):
    merchantID = models.CharField(primary_key=True, max_length=200)
    merchantName = models.CharField(max_length=100, blank=False)
    category = models.CharField(max_length=50, default='OTHERS')
    streetAddress = models.CharField(max_length=100, blank=False, default='900 Metro Center Blvd')
    city = models.CharField(max_length=50, blank=False, default='Foster City')
    state = models.CharField(max_length=50, blank=False, default='CA')
    zipcode = models.CharField(max_length=50, blank=False, default='zipcode_string')
    longitude = models.CharField(max_length=100, blank=False, default='-122.2763649')
    latitude = models.CharField(max_length=100, blank=False, default='37.5592521')
    distance = models.CharField(max_length=100, default='100 m')
    storeID = models.CharField(max_length=100, default='0000000')
    # TODO: check how bank account works with Visa payment: No bank account
    # bankAccount = models.CharField(max_length=200, blank=True)
    profilePic = models.ImageField(default='default_merchant.png', upload_to='merchantLogo/')

    def __str__(self):
        return str(self.merchantName)
