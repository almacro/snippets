"""
This module defines the blockchain node server API.
"""

from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS

from wallet import Wallet
from blockchain import Blockchain

app = Flask(__name__)
CORS(app)


@app.route('/', methods=['GET'])
def get_node_ui():
    """Returns the node UI."""
    return send_from_directory('ui', 'node.html')


@app.route('/network', methods=['GET'])
def get_network_ui():
    """Returns the network UI."""
    return send_from_directory('ui', 'network.html')


@app.route('/wallet', methods=['POST'])
def create_keys():
    """Creates keys and stores them to a new wallet."""
    wallet.create_keys()
    if wallet.save_keys():
        global blockchain
        blockchain = Blockchain(wallet.public_key, port)
        response = {
            'public_key': wallet.public_key,
            'private_key': wallet.private_key,
            'funds': blockchain.get_balance(wallet.public_key),
        }
        return jsonify(response), 201
    else:
        response = {
            'message': 'Saving the keys failed'
        }
        return jsonify(response), 500


@app.route('/wallet', methods=['GET'])
def load_keys():
    """Loads a keypair from an existing wallet file store."""
    if wallet.load_keys():
        global blockchain
        blockchain = Blockchain(wallet.public_key, port)
        response = {
            'public_key': wallet.public_key,
            'private_key': wallet.private_key,
            'funds': blockchain.get_balance(wallet.public_key)
        }
        return jsonify(response), 200
    else:
        response = {
            'message': 'Loading the keys failed'
        }
        return jsonify(response), 500


@app.route('/balance', methods=['GET'])
def get_balance():
    """Gets a wallet's coin balance."""
    balance = blockchain.get_balance(wallet.public_key)
    if balance is not None:
        response = {
            'balance': balance
        }
        return jsonify(response), 200
    else:
        response = {
            'message': 'Balance check failed',
            'wallet_set_up': wallet.public_key is not None,
        }
        return jsonify(response), 500


@app.route('/transaction', methods=['POST'])
def add_transaction():
    """Adds a new open transaction."""
    if wallet.public_key is None:
        response = {
            'message': 'No wallet set up',
        }
        return jsonify(response), 500

    values = request.get_json()
    if not values:
        response = {
            'message': 'No data found'
        }
        return jsonify(response), 400
    required_fields = ['recipient', 'amount']
    if not all(field in values for field in required_fields):
        response = {
            'message': 'Required data missing'
        }
        return jsonify(response), 400
    sender = wallet.public_key
    recipient = values['recipient']
    amount = values['amount']
    signature = wallet.sign_transaction(sender, recipient, amount)
    ok = blockchain.add_transaction(recipient, sender, signature, amount)
    if ok:
        response = {
            'message': 'Transaction added successfully',
            'transaction': {
                'sender': sender,
                'recipient': recipient,
                'amount': amount,
                'signature': signature,
            },
            'funds': blockchain.get_balance(sender)
        }
        return jsonify(response), 201
    else:
        response = {
            'message': 'Creating a transaction failed.',
            'funds': blockchain.get_balance(signature),
        }
        return jsonify(response), 500


@app.route('/mine', methods=['POST'])
def mine():
    """Mines a block and adds it to the blockchain posting all open transactions."""
    if blockchain.resolve_conflicts:
        response = {
            'message': 'Resolve conflicts first, block not added!'
        }
        return jsonify(response), 409
    block = blockchain.mine_block()
    if block is not None:
        dict_block = block.__dict__.copy()
        dict_block['transactions'] = [tx.__dict__ for tx in dict_block['transactions']]
        response = {
            'message': 'Block added successfully',
            'block': dict_block,
            'funds': blockchain.get_balance(wallet.public_key),
        }
        return jsonify(response), 201
    else:
        response = {
            'message': 'Adding a block failed',
            'wallet_set_up': wallet.public_key is not None
        }
        return jsonify(response), 500


@app.route('/broadcast-block', methods=['POST'])
def broadcast_block():
    """Receives notification of a newly added block and adds it to blockchain."""
    values = request.get_json()
    if not values:
        response = {'message': 'No data found'}
        return jsonify(response), 400

    if 'block' not in values:
        response = {'message': "Some data is missing"}
        return jsonify(response), 400
    block = values['block']
    last_block = blockchain.chain[-1]
    if block['index'] == last_block.index + 1:
        if blockchain.add_block(block):
            response = {
                'message': 'Broadcast block added'
            }
            return jsonify(response), 201
        else:
            response = {
                'message': 'Adding a broadcast block failed'
            }
            return jsonify(response), 409
    elif block['index'] > last_block.index:
        response = {
            'message': 'Blockchain seems to differ from local blockchain'
        }
        blockchain.resolve_conflicts = True
        return jsonify(response), 200
    else:
        response = {
            'message': 'Blockchain seems to be shorter, block not added'
        }
        return jsonify(response), 409


@app.route('/broadcast-transaction', methods=['POST'])
def broadcast_transaction():
    """
    Receives notification of a newly added transaction and adds it to
    the open transactions list.
    """

    values = request.get_json()
    if not values:
        response = {'message': 'No data found'}
        return jsonify(response), 400

    required = ['sender', 'recipient', 'amount', 'signature']
    if not all([key in values for key in required]):
        response = {'message': "Some data is missing"}
        return jsonify(response), 400
    ok = blockchain.add_transaction(values['recipient'],
                                    values['sender'],
                                    values['signature'],
                                    values['amount'],
                                    is_receiving=True)
    if ok:
        response = {
            'message': 'Transaction added successfully',
            'transaction': {
                'sender': values['sender'],
                'recipient': values['recipient'],
                'amount': values['amount'],
                'signature': values['signature'],
            }
        }
        return jsonify(response), 201
    else:
        response = {
            'message': 'Creating a transaction failed.',
            'funds': blockchain.get_balance(values['sender']),
        }
        return jsonify(response), 500


@app.route('/resolve-conflicts', methods=['POST'])
def resolve_conflicts():
    """Resolves conflicts in blockchain fork."""
    replaced = blockchain.resolve()
    if replaced:
        response = {
            'message': 'Chain was replaced!'
        }
    else:
        response = {
            'message': 'Local chain kept.'
        }
    return jsonify(response), 200


@app.route('/transactions', methods=['GET'])
def get_open_transactions():
    """Returns the list of open transactions."""
    txs = blockchain.get_open_transactions()
    dict_txs = [tx.__dict__ for tx in txs]
    return jsonify(dict_txs), 200


@app.route('/chain', methods=['GET'])
def get_chain():
    """Returns the list of blocks in the blockchain."""
    chain_snapshot = blockchain.chain
    dict_chain = [block.__dict__.copy() for block in chain_snapshot]
    for dict_block in dict_chain:
        dict_block['transactions'] = [tx.__dict__ for tx in dict_block['transactions']]
    return jsonify(dict_chain), 200


@app.route('/node', methods=['POST'])
def add_node():
    """Adds a new node to the node peers list."""
    values = request.get_json()
    if not values:
        response = {
            'message': 'No data found'
        }
        return jsonify(response, 400)
    if 'node' not in values:
        response = {
            'message': 'No node data found'
        }
        return jsonify(response), 400
    node = values['node']
    blockchain.add_peer_node(node)
    response = {
        'message': 'Node added successfully',
        'all_nodes': blockchain.get_peer_nodes()
    }
    return jsonify(response), 201


@app.route('/node/<node_url>', methods=['DELETE'])
def remove_node(node_url):
    """Removes a node from the node peers list."""
    if not node_url:
        response = {
            'message': 'No node found'
        }
        return jsonify(response, 400)
    blockchain.remove_peer_node(node_url)
    response = {
        'message': 'Node removed',
        'all_nodes': blockchain.get_peer_nodes()
    }
    return jsonify(response), 200


@app.route('/nodes', methods=['GET'])
def get_nodes():
    """Returns the node peers list."""
    response = {
        'all_nodes': blockchain.get_peer_nodes()
    }
    return jsonify(response), 200


if __name__ == "__main__":
    from argparse import ArgumentParser
    parser = ArgumentParser()
    parser.add_argument('-p', '--port', type=int, default=5000)
    args = parser.parse_args()
    port = args.port
    wallet = Wallet(port)
    blockchain = Blockchain(wallet.public_key, port)
    app.run(host='0.0.0.0', port=port)
