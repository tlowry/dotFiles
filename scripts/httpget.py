#!/usr/bin/python
# -*- coding: utf-8 -*-
import urllib,urllib2

# Url + host + a few params 
#urlTemplate = "http://192.168.1.212:8080/notify/rest/notify/newnotification?type=PEAK_RATE&id=87304640&text=\"%s\""
urlTemplate = "http://192.168.1.212:8080/notify/rest/notify/newnotification?type=PEAK_RATE&id=87304640"

# Actual message part
#text = "ССБ HighWater знак 5 сообщ 30 секунд был штанах оригинатором 353862345776 , который в настоящее время отстранены от отправки в течение 1 часа"

text = "test"

# Escape any unicode in the message
text = urllib.quote(text)

# Replace the template variable with escaped text
#urlStr = urlTemplate % text
urlStr = urlTemplate

print(urlStr)

#print urlStr
urllib2.urlopen(urlStr).read()
