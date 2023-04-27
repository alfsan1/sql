import requests
from bs4 import BeautifulSoup
import pandas as pd

def fetch_prices():
    # Replace 'binance.com/exchange/BTCUSDT' with other exchange URLs as necessary
    url = "https://www.binance.com/exchange/BTCUSDT"
    response = requests.get(url)
    
    soup = BeautifulSoup(response.content, "html.parser")
    table = soup.find("table", attrs={"class": "marketSummaryTable__wrapper"})

    data = []
    for row in table.findAll('tr')[1:]:
        cells = row.findAll('td')
        asset = cells[0].a.string
        price = float(cells[2].span['data-base'].split()[-1])
        percentage_change = cells[3].span.contents[-1] + '%' if int(percentage_change) > 0 else ''
        data.append({'asset': asset, 'price': price, 'percentage_change': percentage_change})
        
    df = pd.DataFrame(data)

    return df

if __name__ == '__main__':
    df = fetch_prices()