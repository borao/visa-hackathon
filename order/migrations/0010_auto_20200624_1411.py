# Generated by Django 3.0.7 on 2020-06-24 18:11

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('order', '0009_auto_20200624_1409'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='expiration_date',
            field=models.DateField(auto_created=True, default=datetime.datetime(2020, 7, 8, 14, 11, 39, 518121), editable=False),
        ),
        migrations.AlterField(
            model_name='order',
            name='redeemed',
            field=models.BooleanField(verbose_name=False),
        ),
    ]
