import json
from django.core.management.base import BaseCommand
from merchant.models import Merchant


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('merchantData.json', type=str)

    def handle(self, *args, **options):
        with open(options['merchantData.json']) as f:
            data_list = json.load(f)

        for data in data_list:
            data['pk'] = data.pop('merchantID')
            Merchant.objects.get_or_create(pk=data['pk'], defaults=data)
