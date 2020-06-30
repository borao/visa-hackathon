from django.db.models import Sum
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

# Haven't implemented the logic for redeeming loyalty program yet.
class EnrollmentViewSet(viewsets.ModelViewSet):
    queryset = UserToMerchant.objects.all()
    serializer_class = EnrollmentSerializer

    @action(detail=False,url_path='getAllProgramsByUser/(?P<userID>[^/.]+)')
    def getAllProgramsByUser(self, request, userID):
        programs = self.queryset.filter(userID = userID).values()
        return HttpResponse(programs)

    @action(detail=False,url_path='getActiveProgramsByUser/(?P<userID>[^/.]+)')
    def getActiveProgramsByUser(self, request, userID):
        programs = self.queryset.filter(userID = userID).filter(redeemed=False).values()
        return HttpResponse(programs)

    @action(detail=False,url_path='getRedeemedProgramsByUser/(?P<userID>[^/.]+)')
    def getRedeemedProgramsByUser(self, request, userID):
        programs = self.queryset.filter(userID = userID).filter(redeemed=True).values()
        return HttpResponse(programs)

    @action(detail=False,url_path='getProgramByUserAndMerchant/(?P<userID>[^/.]+)/(?P<merchantID>[^/.]+)')
    def getProgramByUserAndMerchant(self, request, userID, merchantID):
        programs = self.queryset.filter(userID = userID).filter(merchantID = merchantID).filter(redeemed=False).values()
        return HttpResponse(programs)

    # Frontend can just do a post with wanted amount of additional progress, this will update or create the record
    def perform_create(self, serializer):
        program = UserToMerchant.objects \
            .filter(userID = serializer.validated_data['userID']) \
            .filter(merchantID = serializer.validated_data['merchantID']) \
            .filter(programID = serializer.validated_data['programID']) \
            .filter(redeemed=False)
        if len(program)==1:
            print(program.values_list('curProgress',flat=True)[0])
            serializer.save(curProgress= program.values_list('curProgress',flat=True)[0] + serializer.validated_data['curProgress'])
        else:
            serializer.save()

    # http://localhost:8000/programs/enrollment/getFavoriteStore/1/
    @action(detail=False, url_path='getFavoriteStore/(?P<userID>[^/.]+)')
    def getFavoriteStore(self, request, userID):
        stores = self.queryset.filter(userID=userID).select_related().values('userID', 'merchantID', 'merchantID_id__profilePic').annotate(totalPoints=Sum('curProgress')).order_by('-totalPoints')[:10]
        return HttpResponse(stores)
