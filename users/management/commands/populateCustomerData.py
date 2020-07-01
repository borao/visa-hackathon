import json
from django.core.management.base import BaseCommand
from users.models import Customer, User
from users import models as userModel


class Command(BaseCommand):

    def add_arguments(self, parser):
        parser.add_argument('customerData.json', type=str)

    def handle(self, *args, **options):
        with open(options['customerData.json']) as f:
            data_list = json.load(f)

        for data in data_list:
            data['pk'] = data.pop('user')
            User.objects.create_user(username=data['username'], password=data.pop('password'))
            Customer.objects.get_or_create(pk=data['pk'],
                                           user=userModel.User.objects.all().get(username=data.pop('username')),
                                           defaults=data)
