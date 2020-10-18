'''
Example 3. Using openAuth

This example utilizes the configured username and password and allow
read-write access to libvirtd.

It presumes the libvirtd and sasl config prerequisites are in effect.
'''

import sys
import libvirt

SASL_USER = 'my-super-user'
SASL_PASS = 'my-super-pass'

def request_cred(credentials, user_data):
    for credential in credentials:
        if credential[0] == libvirt.VIR_CRED_AUTHNAME:
            credential[4] = SASL_USER
        elif credential[0] == libvirt.VIR_CRED_PASSPHRASE:
             credential[4] = SASL_PASS
    return 0

auth = [[libvirt.VIR_CRED_AUTHNAME, libvirt.VIR_CRED_PASSPHRASE], request_cred, None]
uri  = 'qemu+tcp://localhost/system'
conn = libvirt.openAuth(uri, auth, 0)
if conn == None:
    print(f'Failed to open connection to {uri}', file=sys.stderr)
    exit(1)
conn.close()
exit(0)
