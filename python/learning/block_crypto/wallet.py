"""
This module defines the Wallet type containing bearer identity.
"""

from Crypto.PublicKey import RSA
from Crypto.Signature import PKCS1_v1_5
from Crypto.Hash import SHA256
import Crypto.Random

from utility.util import to_ascii, ascii_key, to_binary

class Wallet:
    """This class defines Wallet behavior."""
    def __init__(self, node_id):
        self.__private_key = None
        self.__public_key = None
        self.__node_id = node_id


    @property
    def private_key(self):
        """Returns the wallet's private key as a read-only property."""
        return self.__private_key


    @property
    def public_key(self):
        """Returns the wallet's public key as a read-only property."""
        return self.__public_key


    @property
    def node_id(self):
        """Returns the wallet host's node id as a read-only property."""
        return self.__node_id


    def has_keys(self):
        """
        Checks whether the wallet contains a bearer's keypair indicating it
        is initialized.
        """

        return self.public_key is not None and self.private_key is not None


    def create_keys(self):
        """Create a key pair to use as bearer identity."""
        private_key, public_key = self.generate_keys()
        self.__private_key = private_key
        self.__public_key = public_key


    def save_keys(self):
        """Stores the wallet to a file store."""
        if self.has_keys():
            try:
                with open('wallet-{}.txt'.format(self.node_id), mode='w') as _file:
                    _file.write(self.public_key)
                    _file.write('\n')
                    _file.write(self.private_key)
                return True
            except (IOError, IndexError):
                print('Saving wallet failed!')
        else:
            print('No keys to save!')
        return False


    def load_keys(self):
        """Loads the wallet from file store."""
        try:
            with open('wallet-{}.txt'.format(self.node_id), mode='r') as _file:
                keys = _file.readlines()

            self.__public_key = keys[0][:-1]
            self.__private_key = keys[1]

            return True
        except (IOError, IndexError):
            print('Loading wallet failed!')
        return False


    def generate_keys(self):
        """Generates a bearer keypair for this wallet."""
        private_key = RSA.generate(1024, Crypto.Random.new().read)
        public_key = private_key.publickey()
        return (ascii_key(private_key), ascii_key(public_key))


    def sign_transaction(self, sender, recipient, amount):
        """Signs a transaction with the sender's keys."""
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
        """Verifies a transaction is properly signed."""
        if transaction.sender == 'MINING':
            return True
        public_key = RSA.importKey(to_binary(transaction.sender))
        verifer = PKCS1_v1_5.new(public_key)
        hash_ = SHA256.new((str(transaction.sender) +
                            str(transaction.recipient) +
                            str(transaction.amount)).encode('utf8'))
        return verifer.verify(hash_, to_binary(transaction.signature))
