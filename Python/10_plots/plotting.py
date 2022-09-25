from cProfile import label
import numpy as np
import math as mt
import matplotlib.pyplot as plt
import pandas as pd

data = pd.read_csv("gas_prices.csv")

# simplest plot
x_data_year = data["Year"]
y_data_prices = data["South Korea"]
x = [1,2,3,4,5,6,7]
y1 = [10,20,30,40,50,60,70]
y2 = [20,40,60,80,100,120,140]

plt.plot(x,y1)
plt.show()


# Many plots in one

plt.plot(x,y1)
plt.plot(x,y2)
plt.show()

# plotting data from pandas
plt.figure(figsize=(8,5))
plt.title("Gas prices over Years")
plt.plot(x_data_year[::3],y_data_prices[::3],'b.-',label="South Korea")     # sharthand for 'color ticks_symbol line_type'
plt.plot(data['Year'][::3],data['USA'][::3],'r.-',label="USA")     # sharthand for 'color ticks_symbol line_type'
plt.xticks(x_data_year[::3])                # shows exact year in x axis
plt.xlabel("Years")
plt.ylabel("Prices in USD")
plt.legend()                # shows legend
plt.show()


# for loops in pandas data
for country in data:
    print(country)                  # prints the headings of data ( in this case country names)
    pass

for country in data["year"]:
    print(country)                  # prints the data ( in this case Years)
    pass
    

