from django.shortcuts import render
from rest_framework import viewsets
from .models import *
from .serializers import *
from merchant.merchant_locator_api.src.customizedMerchantLocator import MerchantLocator
from django.http import JsonResponse
from rest_framework.decorators import action


# Create your views here.

class CustomerViewSet(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer


class FriendShipViewSet(viewsets.ModelViewSet):
    queryset = Friendship.objects.all()
    serializer_class = FriendShipSerializer


class CardViewSet(viewsets.ModelViewSet):
    queryset = Card.objects.all()
    serializer_class = CardSerializer
