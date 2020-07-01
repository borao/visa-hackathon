import json
from django.core.management.base import BaseCommand
from order.models import Order
from users import models as userModel
from merchant import models as merchantModel

class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('orderData.json', type=str)

    def handle(self, *args, **options):
        with open(options['orderData.json']) as f:
            data_list = json.load(f)

        for data in data_list:
            data['pk'] = data.pop('transactionID')
            Order.objects.get_or_create(pk=data['pk'],
                                        senderID=userModel.Customer.objects.all().get(id = data.pop('senderID')) ,
                                        receiverID=userModel.Customer.objects.all().get(id = data.pop('receiverID')),
                                        merchantID=merchantModel.Merchant.objects.all().get(merchantID = data.pop('merchantID')),
                                        defaults=data)
