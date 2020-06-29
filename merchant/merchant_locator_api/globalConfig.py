import os
dirname = os.path.dirname(__file__)
cert = os.path.join(dirname, 'globalConfig_files/cert.pem')
privateKey = os.path.join(dirname, 'globalConfig_files/certificate_PrivateKey.pem')
caCert = os.path.join(dirname, 'globalConfig_files/DigiCertGlobalRootCA.pem')

class GlobalConfig:

	def __init__(self):
		self.present = True
		self.userName = 'NGF0A19KXKI4X39CNUWX21lcmdvk4d97kvIUoJYbfg5Bc3a5I'
		self.password = 'xSEyieNgj1Aehh7ce3KVA6nc6i1hMnC'
		self.certificatePath = cert
			#'ABSOLUTE_PATH_TO_CERTIFICATE'
		self.privateKeyPath = privateKey
			#'ABSOULUTE_PATH_TO_PRIVATE_KEY'
		self.caCertPath = caCert
			#'ABSOLUTE_PATH_TO_CA_CERTIFICATE'
		self.proxyUrl = ''
		self.sharedSecret = 'lTCocyPkswb9Pb-3hS/qyMGAWdTfki6wKGm$hsco'
		self.apiKey = 'R8TA6Z78U18JTRS9XPBS21cge63GSSUz-JMmc6JmkcpZ8J440'
		# self.mleKeyId = 'YOUR_MLE_KEY_ID'
		# self.encryptionPublicKeyPath = 'YOUR_ENCRYPTION_PUBLIC_KEY_PATH'
		# self.decryptionPrivateKeyPath = 'YOUR_DECRYPTION_PRIVATE_KEY_PATH'
