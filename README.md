# CI285_AG
To create executable:
Open terminal and cd to this directory then write the following commands
> cabal build
-- If it says there are missing packages, install them and try again!
> cd dist/build/executables

To input json locally, use the input.json file in the dist/build/Assignment
directory, in which case it must be in the following format:
[{"user":"username","date":"9999-12-31T23:59:59+00:00","temperature":10},{"user":"username","date":"2015-02-28T20:16:12+00:00","temperature":5}]
Then, run the command:
> ./LocalTest

This will copy the json data from input.json to local.json (the output/storage
file for html), overwriting any data with the same username and timestamps.

To run the server type:
> 

To input json via a URL, host it at an accessible location with the
following format:
{"temperatures":[
	{"user":"username", "date":"2015-02-28T20:16:12+00:00", "temperature":0},
	{"user":"username", "date":"2015-01-01T21:46:55+00:00", "temperature":2}
]}


# CI285_AG
