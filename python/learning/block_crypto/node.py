from uuid import uuid4

from blockchain import Blockchain
from wallet import Wallet

from utility.verification import Verification as verifier

class Node():
    def __init__(self):
        self.wallet = Wallet()
        self.blockchain = Blockchain(self.wallet.public_key)
        
    @staticmethod
    def get_transaction_value():
        """Returns the input of the user (a new transaction amount)
        as a float."""
        tx_recipient = input('Enter the recipient of the transaction:  ')
        tx_amount = float(input('Enter transaction amount: '))
        return (tx_recipient, tx_amount)

    @staticmethod
    def get_user_choice():
        """Returns the choice of the user (a menu option)
        as a string."""
        return input('Enter choice: ')
    
    
    def print_blockchain_elements(self):
        """Output the blockchain list to the console"""
        for block in self.blockchain.get_chain():
            print('Found block:')
            print(block)
        else:
            print('-' * 20)


    def listen_for_input(self):
        waiting_for_input = True
        while waiting_for_input:
            print('Please choose')
            print('1: Add a new transaction value')
            print('2: Mine a new block')
            print('3: Output the blockchain blocks')
            print('4: Check transaction integrity')
            print('5: Create wallet')
            print('6: Load wallet')
            print('7: Save keys')
            print('q: Quit')
            user_choice = self.get_user_choice()
            if user_choice == '1':
                tx_data = self.get_transaction_value()
                sender = self.wallet.public_key
                recipient, amount = tx_data
                signature = self.wallet.sign_transaction(sender, recipient, amount)
                if self.blockchain.add_transaction(recipient, sender, signature, amount=amount):
                    print('Transaction added!')
                else:
                    print('Transaction failed!')
                print(self.blockchain.get_open_transactions())
            elif user_choice == '2':
                if self.blockchain.mine_block():
                    print('New block added!')
                else:
                    print('Mining failed!')
            elif user_choice == '3':
                self.print_blockchain_elements()
            elif user_choice == '4':
                if verifier.verify_transactions(self.blockchain.get_open_transactions(), self.blockchain.get_balance):
                    print('All transactions are valid')
                else:
                    print('There are invalid transactions')
            elif user_choice == '5':
                self.wallet.create_keys()
                self.blockchain = Blockchain(self.wallet.public_key)
            elif user_choice == '6':
                self.wallet.load_keys()
                self.blockchain = Blockchain(self.wallet.public_key)
            elif user_choice == '7':
                self.wallet.save_keys()
            elif user_choice == 'q':
                waiting_for_input = False
            else:
                print('Input was invalid. Please pick a value from the list.')
            if not verifier.verify_chain(self.blockchain.get_chain()):
                self.print_blockchain_elements()
                print('Invalid blockchain!')
                break
            id = self.wallet.public_key
            print('Balance of {}: {:6.2f}'.format(id, self.blockchain.get_balance(id)))
        print('Done!')
        
if __name__ == '__main__':
    node = Node()
    node.listen_for_input()