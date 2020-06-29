# coding: utf-8

"""
    Merchant Locator API

    Find Visa accepting merchants around by geolocation

    OpenAPI spec version: v1
    Contact: 
    Generated by: https://github.com/swagger-api/swagger-codegen.git
"""


import os
import sys
import unittest
import datetime
import pytz
import random
import string
import re
import json

from merchant.merchant_locator_api.src.apis.merchant_locator_api import MerchantLocatorApi
# from src.apis.merchant_locator_api import MerchantLocatorApi
from merchant.merchant_locator_api.src.configuration import Configuration
# from src.configuration import Configuration
from merchant.merchant_locator_api.globalConfig import GlobalConfig
# from globalConfig import GlobalConfig


class TestMerchantLocatorApi(unittest.TestCase):
    """ MerchantLocatorApi unit test stubs """

    @classmethod
    def setUpClass(self):
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

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def transformPayload(self, payload):
        payload = self.editLocalTime(payload)
        payload = self.addRandom(payload)
        payload = json.loads(payload)
        return payload

    def editLocalTime(self, payload):
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

    def addRandom(self, payload):
        if payload == 'mle_keyId':
            return self.mleKeyId
        payload = re.sub(r'random_string', ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8)), payload)
        payload = re.sub(r'random_integer', ''.join(random.choice(string.digits) for _ in range(8)), payload)
        payload= re.sub(r'random', ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8)), payload)
        return payload

    """
    Test case for postmerchant_locator.
    """
    def testpostmerchant_locator(self):
        print("\npostmerchant_locator")
        result = self.api.postmerchant_locator(self.transformPayload('{"responseAttrList":["GNLOCATOR"],"header":{"messageDateTime":"2016-04-12T22:41:17.903","startIndex":"0","requestMessageId":"Request_001"},"searchOptions":{"matchScore":"true","maxRecords":"5","matchIndicators":"true"},"searchAttrList":{"distance":"2","merchantName":"Starbucks","longitude":"-121.929163","merchantCountryCode":"840","distanceUnit":"M","latitude":"37.363922"}}'))
        pass


if __name__ == '__main__':
    unittest.main()


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
# ----------------------------------------------------------------------------------------------------------------------