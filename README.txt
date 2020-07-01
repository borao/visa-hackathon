# Create a virtual environment to isolate our package dependencies locally
python3 -m venv env
source env/bin/activate

# Install Django and Django REST framework into the virtual environment
pip install django
pip install djangorestframework

# If heroku is not installed:
pip install django-heroku

# If requests is not installed:
pip3 install requests

# If Pillow is not installed:
python -m pip install Pillow



# We'll also create an initial user named admin with a password of password123.
# We'll authenticate as that user later in our example.
python manage.py createsuperuser --email betalink@example.com --username betalink --password password123

# for search OTHERS: USE ZIPCODE 94129, otherwise no result will return
# because prepoluated data come from this zipcode only

python manage.py populateOrderData order/data/orderData.json
python manage.py populateMerchantData merchant/data/merchantData.json
python manage.py populateCustomerData merchant/data/customerData.json
