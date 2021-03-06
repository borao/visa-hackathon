# coding: utf-8

"""
    Merchant Locator API

    Find Visa accepting merchants around by geolocation

    OpenAPI spec version: v1
    Contact:
    Generated by: https://github.com/swagger-api/swagger-codegen.git
"""


from __future__ import absolute_import

import datetime
import pytz
import random
import string
import json
import re
import merchant


from merchant.merchant_locator_api.src.apis.merchant_locator_api import MerchantLocatorApi
# from src.apis.merchant_locator_api import MerchantLocatorApi
from merchant.merchant_locator_api.src.configuration import Configuration
# from src.configuration import Configuration
from merchant.merchant_locator_api.globalConfig import GlobalConfig


class MerchantLocator:

    def __init__(self):
        self.__setUpClass()

    @classmethod
    def __setUpClass(self):
        print("---------------------------------------Tests---------------------------------------\nProduct Name: Merchant Locator\nApi Name: Merchant Locator API")
        globalConfig = GlobalConfig()
        config = Configuration()
        config.username = globalConfig.userName
        config.password = globalConfig.password
        config.cert_file = globalConfig.certificatePath
        config.key_file = globalConfig.privateKeyPath
        config.shared_secret = globalConfig.sharedSecret
        config.api_key['apikey'] = globalConfig.apiKey
        config.ssl_ca_cert = globalConfig.caCertPath
        config.proxy_url = globalConfig.proxyUrl
        self.api = MerchantLocatorApi(None)

    def __setUp(self):
        pass

    def __tearDown(self):
        pass

    def __transformPayload(self, payload):
        payload = self.__editLocalTime(payload)
        payload = self.__addRandom(payload)
        payload = json.loads(payload)
        return payload

    def __editLocalTime(self, payload):
        timezone = pytz.timezone("America/Los_Angeles")
        timestamp = timezone.localize(datetime.datetime.now()).strftime('%Y-%m-%dT%H:%M:%S')
        pattern = re.compile('"localTransactionDateTime":".{19}"', re.IGNORECASE)
        replacement = '"localTransactionDateTime": "'+timestamp+'"'
        payload = re.sub(pattern, replacement, payload)

        timestamp = timezone.localize(datetime.datetime.now()).strftime('%m%d%H%M%S')
        pattern = re.compile('"dateTimeLocal":".{10}"', re.IGNORECASE)
        replacement = '"dateTimeLocal": "'+timestamp+'"'
        payload = re.sub(pattern, replacement, payload)
        return payload

    def __addRandom(self, payload):
        if payload == 'mle_keyId':
            return self.mleKeyId
        payload = re.sub(r'random_string', ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8)), payload)
        payload = re.sub(r'random_integer', ''.join(random.choice(string.digits) for _ in range(8)), payload)
        payload = re.sub(r'random', ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8)), payload)
        return payload

    def numRecordMatched(self, payload):
        print('----------- Find the number of records matched ------------')
        print(payload)

        result = self.api.postmerchant_locator(self.__transformPayload(payload))
        print(result)

        merchantResponse = json.loads(self.api.api_client.last_response.data)
        matched_records = merchantResponse["merchantLocatorServiceResponse"]["header"]["numRecordsMatched"]
        print("matched_records: ",  matched_records)
        return matched_records

    """
    Test case for postmerchant_locator.
    """
    def __testpostmerchant_locator(self, payload):

        print("\npostmerchant_locator")
        result = self.api.postmerchant_locator(self.__transformPayload(payload))
        merchantResponse = json.loads(self.api.api_client.last_response.data)
        merchantInfo = merchantResponse["merchantLocatorServiceResponse"]["response"][0]["responseValues"]

        a_merchant = {
            "merchantName": merchantInfo["visaMerchantName"],
            "merchantID": merchantInfo["visaMerchantId"],
            "storeID": merchantInfo['visaStoreId'],
            "streetAddress": merchantInfo["merchantStreetAddress"],
            "zipcode": merchantInfo["merchantPostalCode"],
            "state": merchantInfo["merchantState"],
            "city": merchantInfo["merchantCity"],
            "category": merchantInfo["merchantCategoryCodeDesc"][0],
            "distance": merchantInfo["distance"],
            "longitude": merchantInfo["locationAddressLongitude"],
            "latitude": merchantInfo["locationAddressLatitude"]
        }

        return a_merchant

    def postSearch_by_Category(self, start_idx, distance, merchantCategoryCode, zipcode):
        attrList = '"searchAttrList":{"distance": "' + str(distance) + \
                   '","merchantCategoryCode":[' + merchantCategoryCode + \
                   '],"merchantCountryCode":"840", "distanceUnit":"m", "merchantPostalCode":"' + zipcode + '"}}'
        payload = '{"responseAttrList":["GNLOCATOR"],' \
                  '"header":{"messageDateTime":"2020-06-22T22:41:17.903",' \
                  '"startIndex":"' + str(start_idx) + '", "requestMessageId":"Request_001"},' + attrList

        numRecords = self.numRecordMatched(payload)

        merchant_list = []

        if numRecords >= 1:
            total = 1 if numRecords > 1 else numRecords
            if numRecords > 1:
                for i in range(total):
                    # TODO: filter redundant stores
                    payload = '{"responseAttrList":["GNLOCATOR"],' \
                              '"header":{"messageDateTime":"2020-06-22T22:41:17.903",' \
                              '"startIndex": "' + str(start_idx) + '", "requestMessageId":"Request_001"},' + attrList
                    print(payload)
                    merchant_list.append(self.__testpostmerchant_locator(payload))

        return merchant_list

    def postSearch_by_Name(self, start_idx, distance, merchantName, longitude, latitude):
        attrList = '"searchAttrList":{"distance": "' + str(distance) + \
                   '","merchantName":"' + merchantName + \
                   '","merchantCountryCode":"840", "distanceUnit":"m", ' \
                   '"longitude":"' + longitude + '", "latitude":"' + latitude + '"}}'
        payload = '{"responseAttrList":["GNLOCATOR"],' \
                  '"header":{"messageDateTime":"2020-06-22T22:41:17.903",' \
                  '"startIndex":"' + str(start_idx) + '", "requestMessageId":"Request_001"},' + attrList

        print(payload)

        numRecords = self.numRecordMatched(payload)

        merchant_list = []

        if numRecords >= 1:
            total = 1 if numRecords > 1 else numRecords
            if numRecords > 1:
                for i in range(total):
                    payload = '{"responseAttrList":["GNLOCATOR"],' \
                              '"header":{"messageDateTime":"2020-06-22T22:41:17.903",' \
                              '"startIndex": "' + str(start_idx) + '", "requestMessageId":"Request_001"},' + attrList
                    print(payload)
                    merchant_list.append(self.__testpostmerchant_locator(payload))

        return merchant_list


# ----------------------------------------------------------------------------------------------------------------------
# © Copyright 2018 Visa. All Rights Reserved.
#
# NOTICE: The software and accompanying information and documentation (together, the “Software”) remain the property of
# and are proprietary to Visa and its suppliers and affiliates. The Software remains protected by intellectual property
# rights and may be covered by U.S. and foreign patents or patent applications. The Software is licensed and not sold.
#
# By accessing the Software you are agreeing to Visa's terms of use (developer.visa.com/terms) and privacy policy
# (developer.visa.com/privacy). In addition, all permissible uses of the Software must be in support of Visa products,
# programs and services provided through the Visa Developer Program (VDP) platform only (developer.visa.com).
# THE SOFTWARE AND ANY ASSOCIATED INFORMATION OR DOCUMENTATION IS PROVIDED ON AN “AS IS,” “AS AVAILABLE,” “WITH ALL
# FAULTS” BASIS WITHOUT WARRANTY OR CONDITION OF ANY KIND. YOUR USE IS AT YOUR OWN RISK.
