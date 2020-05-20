import requests
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--symbols", type=str, nargs='+', required=True)
args = parser.parse_args()

symbols = args.symbols

QUOTE_URL = 'https://finnhub.io/api/v1/quote?symbol={}&token=bqpshcvrh5rcg6od3n30'

for symbol in symbols:
    try:
        r = requests.get(QUOTE_URL.format(symbol))
        info = r.json()
    except:
        continue

    change = (info['c'] - info['pc']) * 100 / info['pc']
    change_sign = '+' if change >= 0 else '-'

    msg = symbol
    msg += ': {} ({}{:.2f}%)'
    msg = msg.format(info['c'], change_sign, abs(change))

    print(msg)
