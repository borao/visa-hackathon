from rest_framework import serializers

from .models import Customer, Card, Friendship


class CustomerSerializer(serializers.ModelSerializer):

    class Meta:
        model = Customer
        fields = '__all__'


class CardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Card
        fields = '__all__'


class FriendShipSerializer(serializers.ModelSerializer):
    class Meta:
        model = Friendship
        fields = '__all__'
