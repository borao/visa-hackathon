from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets
from rest_framework.decorators import action

from program.models import Program, UserToMerchant
from program.serializers import ProgramSerializer, EnrollmentSerializer


class ProgramViewSet(viewsets.ModelViewSet):
    queryset = Program.objects.all()
    serializer_class = ProgramSerializer

class EnrollmentViewSet(viewsets.ModelViewSet):
    queryset = UserToMerchant.objects.all()
    serializer_class = EnrollmentSerializer

    @action(detail=False,url_path='getProgramsByUser/(?P<userID>[^/.]+)')
    def getProgramsByUser(self, request, userID):
        programs = self.queryset.filter(userID = userID).values()
        return HttpResponse(programs)


    # get user's active program

    # user program with merchant