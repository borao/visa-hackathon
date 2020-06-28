# coding: utf-8

"""
    Merchant Locator API

    Find Visa accepting merchants around by geolocation

    OpenAPI spec version: v1
    Contact: 
    Generated by: https://github.com/swagger-api/swagger-codegen.git
"""


from pprint import pformat
from six import iteritems
import re


class Header(object):
    """
    NOTE: This class is auto generated by the swagger code generator program.
    Do not edit the class manually.
    """
    def __init__(self, message_date_time=None, start_index=None, request_message_id=None):
        """
        Header - a model defined in Swagger

        :param dict swaggerTypes: The key is attribute name
                                  and the value is attribute type.
        :param dict attributeMap: The key is attribute name
                                  and the value is json key in definition.
        """
        self.swagger_types = {
            'message_date_time': 'str',
            'start_index': 'int',
            'request_message_id': 'str'
        }

        self.attribute_map = {
            'message_date_time': 'messageDateTime',
            'start_index': 'startIndex',
            'request_message_id': 'requestMessageId'
        }

        self._message_date_time = message_date_time
        self._start_index = start_index
        self._request_message_id = request_message_id

    @property
    def message_date_time(self):
        """
        Gets the message_date_time of this Header.
        Date and time at which Request is sent (up to milliseconds in UTC). Ex: 2008-09-19T00:00:00.000

        :return: The message_date_time of this Header.
        :rtype: str
        """
        return self._message_date_time

    @message_date_time.setter
    def message_date_time(self, message_date_time):
        """
        Sets the message_date_time of this Header.
        Date and time at which Request is sent (up to milliseconds in UTC). Ex: 2008-09-19T00:00:00.000

        :param message_date_time: The message_date_time of this Header.
        :type: str
        """

        self._message_date_time = message_date_time

    @property
    def start_index(self):
        """
        Gets the start_index of this Header.
        Records displayed start at the defined number (Defaulted to 0 if not provided in request)

        :return: The start_index of this Header.
        :rtype: int
        """
        return self._start_index

    @start_index.setter
    def start_index(self, start_index):
        """
        Sets the start_index of this Header.
        Records displayed start at the defined number (Defaulted to 0 if not provided in request)

        :param start_index: The start_index of this Header.
        :type: int
        """

        self._start_index = start_index

    @property
    def request_message_id(self):
        """
        Gets the request_message_id of this Header.
        A string which uniquely identifies the service request. Requesting application need to create this unique message Id

        :return: The request_message_id of this Header.
        :rtype: str
        """
        return self._request_message_id

    @request_message_id.setter
    def request_message_id(self, request_message_id):
        """
        Sets the request_message_id of this Header.
        A string which uniquely identifies the service request. Requesting application need to create this unique message Id

        :param request_message_id: The request_message_id of this Header.
        :type: str
        """

        self._request_message_id = request_message_id

    def to_dict(self):
        """
        Returns the model properties as a dict
        """
        result = {}

        for attr, _ in iteritems(self.swagger_types):
            value = getattr(self, attr)
            if isinstance(value, list):
                result[attr] = list(map(
                    lambda x: x.to_dict() if hasattr(x, "to_dict") else x,
                    value
                ))
            elif hasattr(value, "to_dict"):
                result[attr] = value.to_dict()
            elif isinstance(value, dict):
                result[attr] = dict(map(
                    lambda item: (item[0], item[1].to_dict())
                    if hasattr(item[1], "to_dict") else item,
                    value.items()
                ))
            else:
                result[attr] = value

        return result

    def to_str(self):
        """
        Returns the string representation of the model
        """
        return pformat(self.to_dict())

    def __repr__(self):
        """
        For `print` and `pprint`
        """
        return self.to_str()

    def __eq__(self, other):
        """
        Returns true if both objects are equal
        """
        if not isinstance(other, Header):
            return False

        return self.__dict__ == other.__dict__

    def __ne__(self, other):
        """
        Returns true if both objects are not equal
        """
        return not self == other

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