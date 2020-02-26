import bs4
import requests

res=requests.get('https://smallwebsite.us/')
soup=bs4.BeautifulSoup(res.text,'lxml')
print(soup.prettify())