from Crypto.PublicKey import RSA
from Crypto.Signature import PKCS1_v1_5
from Crypto.Hash import SHA256
import Crypto.Random
import binascii

from utility.util import to_ascii, ascii_key, to_binary

class Wallet:
    def __init__(self):
        self.private_key = None
        self.public_key = None

    def has_keys(self):
        return self.public_key != None and self.private_key != None

    def create_keys(self):
        private_key, public_key = self.generate_keys()
        self.private_key = private_key
        self.public_key = public_key


    def save_keys(self):
        if self.has_keys():
            try:
                with open('wallet.txt', mode='w') as f:
                    f.write(self.public_key)
                    f.write('\n')
                    f.write(self.private_key)
            except (IOError, IndexError):
                print('Saving wallet failed!')
        else:
            print('No keys to save!')

    def load_keys(self):
        try:
            with open('wallet.txt', mode='r') as f:
                keys = f.readlines()

            self.public_key = keys[0][:-1]
            self.private_key = keys[1]
        except (IOError, IndexError):
            print('Loading wallet failed!')


    def generate_keys(self):
        private_key = RSA.generate(1024, Crypto.Random.new().read)
        public_key = private_key.publickey()
        return (ascii_key(private_key), ascii_key(public_key))


    def sign_transaction(self, sender, recipient, amount):
        if not self.has_keys():
            print('Wallet has no keys!')
            # should throw exception here
            return
        signer = PKCS1_v1_5.new(RSA.importKey(to_binary(self.private_key)))
        hash_ = SHA256.new((str(sender) + str(recipient) + str(amount)).encode('utf8'))
        signature = signer.sign(hash_)
        return to_ascii(signature)

    @staticmethod
    def verify_transaction(transaction):
        if(transaction.sender == 'MINING'):
            return True
        public_key = RSA.importKey(to_binary(transaction.sender))
        verifer = PKCS1_v1_5.new(public_key)
        hash_ = SHA256.new((str(transaction.sender) + str(transaction.recipient) + str(transaction.amount)).encode('utf8'))
        return verifer.verify(hash_, to_binary(transaction.signature))
