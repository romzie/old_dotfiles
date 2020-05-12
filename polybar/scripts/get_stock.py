import requests
import sys
import time

short = False
if len(sys.argv) > 1 and sys.argv[1] == '--short':
    short = True

QUOTE_URL = 'https://finnhub.io/api/v1/quote?symbol={}&token=bqpshcvrh5rcg6od3n30'

symbols = [
    ('BNP.PA', 'BNP Paribas'),
    ('AIR.PA', 'Airbus'),
    ('GLE.PA', 'Societe Generale'),
    ('AC.PA', 'Accor')
]

for symbol, name in symbols:
    r = requests.get(QUOTE_URL.format(symbol))
    try:
        info = r.json()
    except:
        continue

    change = (info['c'] - info['pc']) * 100 / info['pc']
    change_sign = '+' if change >= 0 else '-'

    if short:
        msg = symbol
        msg += ': {} ({}{:.2f}%)'
        msg = msg.format(info['c'], change_sign, abs(change))

    else:
        msg = name
        msg += ' Previous Close {} Open {} High {} Low {} Current {} ({}{:.2f}%)'
        msg = msg.format(
            info['pc'],
            info['o'],
            info['h'],
            info['l'],
            info['c'],
            change_sign,
            abs(change)
        )

    print(msg)
