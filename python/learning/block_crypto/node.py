from uuid import uuid4

from blockchain import Blockchain
from verification import Verification as verifier

class Node():
    def __init__(self):
        #self.id = str(uuid4())
        self.id = 'Kwaku'
        self.blockchain = Blockchain(self.id)
        
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
            print('Outputting block:')
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
            print('q: Quit')
            user_choice = self.get_user_choice()
            if user_choice == '1':
                tx_data = self.get_transaction_value()
                recipient, amount = tx_data
                if self.blockchain.add_transaction(recipient, self.id, amount=amount):
                    print('Transaction added!')
                else:
                    print('Transaction failed!')
                print(self.blockchain.get_open_transactions())
            elif user_choice == '2':
                self.blockchain.mine_block()
            elif user_choice == '3':
                self.print_blockchain_elements()
            elif user_choice == '4':
                if verifier.verify_transactions(self.blockchain.get_open_transactions(), self.blockchain.get_balance):
                    print('All transactions are valid')
                else:
                    print('There are invalid transactions')
            elif user_choice == 'q':
                waiting_for_input = False
            else:
                print('Input was invalid. Please pick a value from the list.')
            if not verifier.verify_chain(self.blockchain.get_chain()):
                self.print_blockchain_elements()
                print('Invalid blockchain!')
                break
            print('Balance of {}: {:6.2f}'.format(self.id, self.blockchain.get_balance(self.id)))
        print('Done!')
        
if __name__ == '__main__':
    node = Node()
    node.listen_for_input()