def pyramid(n):
    pyr = []
    c = 1
    for i in range(1,n+1):
        l = []
        for j in range(i):
            l.append(c)
            c = c + 1

        pyr.append(l)

    return pyr

def decode(message_file):
    d = dict()
    for line in message_file:
        els = line.split()
        print(els)
        d[int(els[0])] = els[1]

    print(d)
    m = [d[i] for i in [x[-1] for x in pyramid(3)]]
    print(m)

    return ' '.join(m)

if __name__ == '__main__':
    f = open('input.txt', 'r')
    print(decode(f))
