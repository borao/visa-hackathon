import json
from django.core.management.base import BaseCommand
from program.models import Program, UserToMerchant


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('programData.json', type=str)

    def handle(self, *args, **options):
        with open(options['programData.json']) as f:
            data_list = json.load(f)

        for data in data_list:
            data['pk'] = data.pop('programID')
            Program.objects.get_or_create(pk=data['pk'], defaults=data)
