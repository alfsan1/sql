# Import necessary modules and initialize variables
import pandas as pd
import numpy as np
import plotly.express as px
import datetime

# Create a function to fetch recent data from Coinbase API
def get_recent_data():
    # Replace YOUR_API_KEY with your actual API key here
    api_key = "<YOUR_API_KEY>"
    
    querystring = {"exchangeId":"GDAX","datatypeId":1,"orderDirection":"asc"}
    url = f"/products/BTC-USDC/{int(date.today().timestamp()):.0f}/spot/prices/current"
    while True:
        response = requests.get(url, headers={"CB-ACCESS-KEY":api_key}, params=querystring)
        if "error" not in response.json():
            break
        print(response.json())
    
    data = []
    while "values" in response.json():
        values = response.json()["values"][::-1]
        timestamp = int(values[0][0]) / 1000.0
        item = {
            "asset1_price": float(values[0][2]),
            "asset2_price": float(values[1][2]),
            "spread": values[1][2] - values[0][2],
            "timestamp": timestamp
        }
        data.append(item)
        response = responses.pop()
    
    return data

if __name__ == "__main__":
    try:
        data = get_recent_data()
        df = pd.DataFrame(data).sort_values(by=["timestamp"], ascending=False)[:30]
        print(df)
    except Exception as e:
        print("Error occurred while fetching data: {}".format(e))