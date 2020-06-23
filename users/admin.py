from django.contrib import admin

# Register your models here.
from .models import *


class CustomerAdmin(admin.ModelAdmin):
    pass


admin.site.register(Customer, CustomerAdmin)
admin.site.register(Order)
# admin.site.register(Friendship)
admin.site.register(Card)
