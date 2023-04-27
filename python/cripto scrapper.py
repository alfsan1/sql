import requests
from bs4 import BeautifulSoup
import pandas as pd
import plotly.graph_objects as go
import numpy as np
from dash import Dash, Input, Output, LabelSet, callback_query_component

app = Dash(__name__)

# Initialize empty dataframe
df = pd.DataFrame({"Asset": [], "Price": [], "Percentage Change": [], "Time Difference (minutes)" : [] })

@app.callback(Output("assets"), [Input("searchbar", type=str)], [State("submitbutton", type=StringWidget), State("refresh button", type=StringWidget)])
def update_dataframe(search, submit, refresh):
    if len(search) < 8:
        raise ValueError("Please enter at least 6 characters for search term.")
    assets = {"BTCUSDT", "ETHUSDT", "XRPUSDT"}
    filtered_data = []
    for asset in assets:
        if asset.lower().startswith(search.lower()):
            # Fetch latest exchange prices from Binance API
            response = requests.get(f"https://api.binance.com/api/v3/ticker/{asset}?interval=5m")
            data = response.json()["symbol"]
            lastPrice = data["lastPrice"]["amount"];
            
            # Get current prices from scraped webpage
            asset_scrape = "http://www.thecryptocurrencylist.com/"+asset+"_usdt"
            response = requests.get(asset_scrape)
            soup = BeautifulSoup(