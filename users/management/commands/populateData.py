import json
from django.core.management.base import BaseCommand
from users.models import Customer


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('userData.json', type=str)

    def handle(self, *args, **options):
        with open(options['userData.json']) as f:
            data_list = json.load(f)

        for data in data_list:
            data['pk'] = data.pop('user')
            Customer.objects.get_or_create(pk=data['pk'], defaults=data)
