from unittest import TestCase
from .MerchantLocator import MerchantLocator
from multiprocessing import Pool


class TestMerchantLocator(TestCase):
    def test_post_search_by_category(self):
        merchant_locator = MerchantLocator()
        p = Pool(5)
        result = p.map(merchant_locator.postSearch_by_Category, range(10))
        print(result)