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
http://phaze.space/simple-service-webapp/webapi/getsuburbs?postcode=|Retrieve list of available suburbs for a particular post code
http://phaze.space/simple-service-webapp/webapi/getsuburbsbystate?state=|Retrieve list of available suburbs for a particular state
http://phaze.space/simple-service-webapp/webapi/question|Retrieve a list of questions of useful information that may be retrieved from the database
