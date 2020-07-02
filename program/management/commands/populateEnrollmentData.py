import json
from django.core.management.base import BaseCommand
from program.models import Program, UserToMerchant
from users import models as userModel
from program import models as programModel
from merchant import models as merchantModel

class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('enrollmentData.json', type=str)

    def handle(self, *args, **options):
        with open(options['enrollmentData.json']) as f:
            data_list = json.load(f)

        for data in data_list:
            data['pk'] = data.pop('id')
            UserToMerchant.objects.get_or_create(pk=data['pk'],
                                                 userID=userModel.Customer.objects.all().get(id = data.pop('userID')),
                                                 merchantID=merchantModel.Merchant.objects.all().get(merchantID = data.pop('merchantID')),
                                                 programID=programModel.Program.objects.all().get(programID = data.pop('programID')),
                                                 defaults=data)