# CI285_AG

To create executables:
Open terminal and cd to this directory then write the following commands
> cabal build <br>
-- If it says there are missing packages, install them and try again! <br>
> cd dist/build/executables

To input json locally, use the input.json file in the dist/build/Assignment
directory, in which case it must be in the following format:
[{"user":"username","date":"9999-12-31T23:59:59+00:00","temperature":10},{"user":"username","date":"2015-02-28T20:16:12+00:00","temperature":5}]
Then, run the command:
> ./LocalTest

This will copy the json data from input.json to local.json (the output/storage
file for html), overwriting any data with the same username and timestamps.

To run the server type:
> ./Main

To access the server go to localhost:8000/output in your prefered web browser.
This will display the state of the local.json file when this page was first 
accessed after the command ./Main was entered.

Currently the Happstack server will 'cache' the first response to the directory /output. This means you will have to interupt (ctrl+c) the server (./Main) and start it again to display the latest version ofthe file.

This is due to Happstack only taking pure functions, so it thinks it does not need to re-calculate the output. This could have been fixed by installing happstack-plugins to tell the server to lead pages dynamically however Cabal broke completely when trying to install the package. 

I have tried to make Happstack refresh the file data automatically when 
the output page was accessed again using LiftIO, although I could not 
find a way around the mis-matched types. I also tried using 
happstack-plugins but several sub-packages could not be installed.
Sorry for the inconvenience.

To input json via a URL, host it at an accessible location with the
following format (if you view the output page you will see several samples):
{"temperatures":[
	{"user":"username", "date":"2015-02-28T20:16:12+00:00", "temperature":0},
	{"user":"username", "date":"2015-01-01T21:46:55+00:00", "temperature":2}
]}

Each time you input json via LocalTest or the Happstack server, values that
were previously stored in the file with the same username and time will 
be overwritten, and other values will be appended to the end of the file.

sources used when creating project: 
http://hackage.haskell.org/ -- various package directories
https://www.fpcomplete.com/school/starting-with-haskell/libraries-and-frameworks/text-manipulation/json
http://happstack.com/docs/crashcourse/index.html#serving-files-from-a-directory
http://stackoverflow.com/questions/6009384/exception-handling-in-haskell
