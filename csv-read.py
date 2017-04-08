#This does not actually work, but if it were to work, it probably would look something like this.

import csv
import urllib
import urllib2
englishwords = []
both = {}
with open("words.csv", "rb") as csvfile:
    wordreader = csv.reader(csvfile," " , "|")
    for row in wordreader:
        englishwords.append(str(row))
#This opens any csv file with a list of english words and turns it into a list in Python.
url = "https://translation.googleapis.com/language/translate/v2?key=YOUR_API_KEY"
#This is the Google Translate language-linking base URL. All other protocols are tacked onto the end.
for term in englishwords:
    values = {"q" : term,
              "source" : "en",
              "target" : "fr" }
#q is the text to be translated, source is the language from which the text originates, and target is the language to translate into
    data = urllib.urlencode(values)
    req = urllib2.Request(url, data)
    response = urllib2.urlopen(req)
#magic urllib stuff to get the data response
    translated = response.read()
    both[term] = response.read()[data][translatedtext]
#adding a dictionary entry of "english word" : "translated word" using urllib.read()
with open('translatedwords.csv', 'wb') as csvfile:
    for term in both.keys():
        writer = csv.writer(csvfile, delimiter=' ', ''|', quoting=csv.QUOTE_MINIMAL)
        writer.writerow(both[term] + " : " + term)
#writes the dictionary entries into a new csv file for use by swift.