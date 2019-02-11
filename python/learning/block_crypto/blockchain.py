# Initializing our blockchain list
MINING_REWARD = 10

genesis_block = {
        'previous_hash': '',
        'index': 0,
        'transactions': []
    }
blockchain = [genesis_block]
open_transactions = []
owner = 'Kwaku'
participants = {'Kwaku'}


def hash_block(block):
    return '-'.join([str(block[key]) for key in block])


def get_balance(participant):
    tx_sender = [[tx['amount'] for tx
                  in block['transactions']
                  if tx['sender'] == participant] for block in blockchain]
    open_tx_sender = [tx['amount'] for tx
                      in open_transactions
                      if tx['sender'] == participant]
    tx_sender.extend(open_tx_sender)
    amount_sent = 0
    for tx in tx_sender:
        if len(tx) > 0:
            for amount in tx:
                amount_sent += amount

    tx_recipient = [[tx['amount'] for tx
                    in block['transactions']
                    if tx['recipient'] == participant] for block in blockchain]
    amount_received = 0
    for tx in tx_recipient:
        if len(tx) > 0:
            for amount in tx:
                amount_received += amount
    return amount_received - amount_sent


def get_last_blockchain_value():
    """Returns the last value of the current blockchain.
    """
    if not blockchain:
        return None
    return blockchain[-1]

    
def verify_chain():
    """Verify the current blockchain and return True if it's valid, False otherwise
    """
    for (index, block) in enumerate(blockchain):
        if index == 0:
            continue
        if block['previous_hash'] != hash_block(blockchain[index - 1]):
            return False
    return True


def verify_transaction(transaction):
    """Verify sender has sufficient balance to allow transaction to be processed"""
    sender_balance = get_balance(transaction['sender'])
    return sender_balance >= transaction['amount']


def verify_transactions():
    """Verify pending transactions can be committed to blockchain"""
    return all([verify_transaction(tx) for tx in open_transactions])

def add_transaction(recipient, sender=owner, amount=1.0):
    """Append a new value as well as the last blockchain value
    to the blockchain.
    
    Arguments:
        :sender: The sender of the coins
        :recipient: The recipient of the coins
        :amount: The amount of coins sent with the transaction (default = 1.0)
    """
    transaction = {
        'sender': sender,
        'recipient': recipient,
        'amount': amount
    }
    if verify_transaction(transaction):
        open_transactions.append(transaction)
        participants.add(transaction['sender'])
        participants.add(transaction['recipient'])
        return True
    return False

def mine_block():
    last_block = blockchain[-1]
    hashed_block = hash_block(last_block)
    #print(hashed_block)
    reward_transaction = {
        'sender': 'MINING',
        'recipient': owner,
        'amount': MINING_REWARD
    }
    copied_transactions = open_transactions[:]
    copied_transactions.append(reward_transaction)
    block = {
        'previous_hash': hashed_block,
        'index': len(blockchain),
        'transactions': copied_transactions
    }
    blockchain.append(block)
    return True


def get_transaction_value():
    """Returns the input of the user (a new transaction amount)
    as a float."""
    tx_recipient = input('Enter the recipient of the transaction:  ')
    tx_amount = float(input('Enter transaction amount: '))
    return (tx_recipient, tx_amount)


def get_user_choice():
    """Returns the choice of the user (a menu option)
    as a string."""
    return input('Enter choice: ')


def print_blockchain_elements():
    """Output the blockchain list to the console"""
    for block in blockchain:
        print('Outputting block:')
        print(block)
    else:
        print('-' * 20)


# def print_blockchain_participants():
#     """Output the blockchain participants set to the console"""
#     print('Outputting participants:')
#     for party in participants:
#         print(party)
#     else:
#         print('-' * 20)


waiting_for_input = True
while waiting_for_input:
    print('Please choose')
    print('1: Add a new transaction value')
    print('2: Mine a new block')
    print('3: Output the blockchain blocks')
    print('4: Output participants')
    print('5: Check transaction integrity')
    print('h: Manipulate')
    print('q: Quit')
    user_choice = get_user_choice()
    if user_choice == '1':
        tx_data = get_transaction_value()
        recipient, amount = tx_data
        if add_transaction(recipient, amount=amount):
            print('Transaction added!')
        else:
            print('Transaction failed!')
        print(open_transactions)
    elif user_choice == '2':
        if mine_block():
            open_transactions = []
    elif user_choice == '3':
        print_blockchain_elements()
    elif user_choice == '4':
        print(participants)
    elif user_choice == '5':
        if verify_transactions():
            print('All transactions are valid')
        else:
            print('There are invalid transactions')
    elif user_choice == 'h':
        if len(blockchain) >= 1:
            blockchain[0] = {
                'previous_hash': '',
                'index': 0,
                'transactions': [{
                                    'sender': 'Krita',
                                    'recipient': 'Kwaku',
                                    'amount': 100.0
                                }]
            }
    elif user_choice == 'q':
        waiting_for_input = False
    else:
        print('Input was invalid. Please pick a value from the list.')
    if not verify_chain():
        print_blockchain_elements()
        print('Invalid blockchain!')
        break
    print(get_balance('Kwaku'))
print('Done!')