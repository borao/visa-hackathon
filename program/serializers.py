from rest_framework import serializers

from program.models import Program, UserToMerchant


class ProgramSerializer(serializers.ModelSerializer):
    class Meta:
        model = Program
        fields = '__all__'

class EnrollmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserToMerchant
        fields = '__all__'
