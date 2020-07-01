import json
from django.core.management.base import BaseCommand
from users.models import Customer, User


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('customerData.json', type=str)

    def handle(self, *args, **options):
        with open(options['customerData.json']) as f:
            data_list = json.load(f)

        for data in data_list:
            data['pk'] = data.pop('user')
            User.objects.create_user(username=data['pk'], email=f'{data["pk"]}@minions.com', password='glass')
            Customer.objects.get_or_create(pk=data['pk'], defaults=data)
