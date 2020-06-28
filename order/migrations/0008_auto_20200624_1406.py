# Generated by Django 3.0.7 on 2020-06-24 18:06

import datetime

import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('order', '0007_auto_20200624_1404'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='date_ordered',
            field=models.DateField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='order',
            name='expiration_date',
            field=models.DateField(auto_created=True, default=datetime.datetime(2020, 7, 8, 14, 6, 42, 335175), editable=False),
        ),
    ]
