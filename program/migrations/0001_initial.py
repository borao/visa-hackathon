# Generated by Django 3.0.7 on 2020-06-29 02:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('users', '0001_initial'),
        ('merchant', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Program',
            fields=[
                ('programID', models.AutoField(primary_key=True, serialize=False)),
                ('programName', models.CharField(max_length=50)),
                ('description', models.TextField()),
                ('goal', models.IntegerField(default=10)),
                ('reward', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='UserToMerchant',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('curProgress', models.IntegerField(default=0)),
                ('redeemed', models.BooleanField(default=False)),
                ('redeemDate', models.DateField(null=True)),
                ('merchantID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='merchant.Merchant')),
                ('programID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='program.Program')),
                ('userID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='users.Customer')),
            ],
        ),
    ]
