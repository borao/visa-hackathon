# Generated by Django 3.0.7 on 2020-06-24 18:18

import datetime

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('order', '0010_auto_20200624_1411'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='expiration_date',
            field=models.DateField(auto_created=True, default=datetime.datetime(2020, 7, 8, 14, 18, 9, 441587), editable=False),
        ),
        migrations.AlterField(
            model_name='order',
            name='redeemed',
            field=models.BooleanField(default=False),
        ),
    ]