# Generated by Django 3.0.7 on 2020-06-24 18:04

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('order', '0006_auto_20200624_1402'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='order',
            name='date_ordered',
        ),
        migrations.RemoveField(
            model_name='order',
            name='expiration_date',
        ),
    ]