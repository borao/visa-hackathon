# Generated by Django 3.0.7 on 2020-06-29 03:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('program', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usertomerchant',
            name='redeemDate',
            field=models.DateField(blank=True, null=True),
        ),
    ]
