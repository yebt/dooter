from bs4 import BeautifulSoup
from urllib.request import urlopen
#import os
from os import path, mkdir, rename

##
URL = "https://www.nerdfonts.com/font-downloads"
LINKS_FILE = "nerd_font_links"

## 
page = urlopen(URL)
html = page.read().decode("utf-8")
soup = BeautifulSoup(html, "html.parser")

links_list = soup.select(".inlineblock.bg-green.border-white.text-white.nerd-font-button.nf-fa-download")

##
file = open(LINKS_FILE, "w")
for lnk in links_list :
    file.write(lnk["href"] + "\n")
file.close()
