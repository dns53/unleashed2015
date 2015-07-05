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
[getsuburbs?postcode=<postcode>](http://phaze.space/simple-service-webapp/webapi/getsuburbs)|Retrieve list of available suburbs for a particular post code
[getsuburbsbystate?state=<state>](http://phaze.space/simple-service-webapp/webapi/getsuburbsbystate)|Retrieve list of available suburbs and postcodes for a particular state
[question](http://phaze.space/simple-service-webapp/webapi/question)|Retrieve a list of questions of useful information that may be retrieved from the database
[answer?id=<question>&postcode1=<postcode1>&postcode2=<postcode2>](http://phaze.space/simple-service-webapp/webapi/answer)|Given a postcode and a view key of one specific one question, retrieve a score. The game will call this twice, and compare the result.

### API : question

Returns a series of questions and a reference to a specific view that is to be used to get the score for that question for a given suburb. Use the question id to pass to the answer API.

Example result:
'''
FIXME
'''

### API : answer

Note how the question returns a field 'x'.

Example query:

'''
FIXME
'''

Example result:
'''
FIXME
'''
