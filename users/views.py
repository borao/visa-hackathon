from rest_framework import viewsets
from rest_framework.decorators import action


from .serializers import *
from django.http import JsonResponse, HttpResponse
from rest_framework.decorators import action


# Create your views here.

class CustomerViewSet(viewsets.ModelViewSet):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer


class FriendShipViewSet(viewsets.ModelViewSet):
    queryset = Friendship.objects.all()
    serializer_class = FriendShipSerializer

    # http://localhost:8000/users/friendship/getFriends/1/
    @action(detail=False,url_path='getFriends/(?P<userID>[^/.]+)')
    def getFriends(self, request, userID):
        friends = self.queryset.filter(friendA = userID).select_related().values('friendB_id__id', 'friendB_id__user__username', 'friendB_id__profilePic')
        return HttpResponse(friends, content_type='application/json')


class CardViewSet(viewsets.ModelViewSet):
    queryset = Card.objects.all()
    serializer_class = CardSerializer
