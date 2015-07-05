# ZacPlus : BurbWars

Code for Unleashed 2015.

See our home page at http://burbwars.weebly.com/

See our hackerspace at https://hackerspace.govhack.org/content/burb-wars

Video : https://youtu.be/Al0YuhbsDE8

Note, due to the size of various data sets, we have not maintained them here in the git repository, other than small ones such as game questions, and postcode rules, etc.

Most of our working notes taken whilst importing data are held in Google Drive

# Web Service API

Presently, the web services is hosted on a VPS used for development and testing purposes.
There is no guarantee that this will remain available at the same location beyond the Govhack Unleashed judging period.

## API web service endpoints

Endpoint|Description|
--------|-----------
[getsuburbs?postcode=5095](http://phaze.space/simple-service-webapp/webapi/getsuburbs)|Retrieve list of available suburbs for a particular post code
[getsuburbsbystate?state=SA](http://phaze.space/simple-service-webapp/webapi/getsuburbsbystate)|Retrieve list of available suburbs and postcodes for a particular state
[question](http://phaze.space/simple-service-webapp/webapi/question)|Retrieve a list of questions of useful information that may be retrieved from the database
[answer?id=1&postcode1=5554&postcode2=5555](http://phaze.space/simple-service-webapp/webapi/answer)|Given a postcode and a view key of one specific one question, retrieve a score. The game will call this twice, and compare the result.

### API : question

Returns a series of questions and a reference to a specific view that is to be used to get the score for that question for a given suburb. Use the question id to pass to the answer API.

Example result:
```
<question category="Education" higher="lower" id="4">Who has the most amount of HECS debt still owing?</question><question category="Education" higher="lower" id="3">Who has the most people with a HECS debt?</question><question category="Education" higher="higher" id="5">Who has the most public shools nearby?</question>
```

### API : answer

Example query:

```
http://phaze.space/simple-service-webapp/webapi/answer?question=3&postcode1=5000&postcode2=5006
```

Example result:
```
<answer>
<question category="Education" higher="lower">Who has the most people with a HECS debt?</question>
<postcode postcode="5000" val="500"/>
<postcode postcode="5006" val="230"/>
</answer>
```

# Unfinished Business

Well, this was a very short weekend hackathon!

* the system is hosted on a test & development VPS. It needs to be deployed to a single purpose VPS or hosting service for real use.
* a production system would configuration manage, script and automate extraction of data from CSV files. This would allow the data to be updated easily from data.sa with a minimum of effort
* a production system would create a data dictionary and data model
* we didnt have time to code up a database or UX for sending feedback automatically to councils, etc
* and so on...
