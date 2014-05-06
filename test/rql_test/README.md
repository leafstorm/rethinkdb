Query Language Tests
--------------------

This folder contains tests for the three official drivers:

* Javascript (js)
* Python (py)
* Ruby (rb)

There are three types of tests:

* Polyglot tests test the query language
* Connection tests test the connection API
* Cursor tests test the cursor API

The test framework is written in python.

### Dependencies

Rethinkdb needs to have `./configure` run, and been built before these tests will work.
Additionally, the javascript tests reuire that both node.js and the mocha test framework.

```
make -C ../..
sudo npm install -g mocha
```

### Running the tests

`./test_runner run` runs all the tests.

`./test_runner list` lists all of the tests.

All the tests except for `make attach` launch their own instance of rethinkdb.
The tests write out data to a `run` folder that is created in the current working directory.
By default, the test suite uses the most recently build rethinkdb binary from ../../build/.
This path can be changed by passing the `-b` or `--build-dir` argument to `test_runner`.

When the tests fail, they return a non-zero exit code. Testing will continue and the
output (STDERR and STDOUT) will be printed to the screen.

### Language tests

The tests can be run for a specific language.

* `./test_runner run -l py`
* `./test_runner run -l js`
* `./test_runner run -l rb`

### Polyglot tests

There are five ways to run the polyglot tests.

* `./test_runner run -f polyglot` runs all the polyglot tests.
* `./test_runner run -f polyglot -l py`
* `./test_runner run -f polyglot -l js`
* `./test_runner run -f polyglot -l rb`
* `./test_runner attach` runs the javascript polyglot tests against a running server. Please see the built-in help for more infomation.

### Connection tests

* `./test_runner run -f connections/connection` run both the javascript and python versions of the tests
* `./test_runner run -l js -f connections/connection`
* `./test_runner run -l py -f connections/connection`

### Cursor tests

* `./test_runner run -f connections/cursor` run both the javascript and python versions of the tests
* `./test_runner run -l js -f connections/cursor`
* `./test_runner run -l py -f connections/cursor`

### Customization

The tests can be customized with command line options:

*  `-b/--build-dir` specifies the build directory to use
*  `-f/--filter` allows a single regex to filter the tests by name
*  `-l/--language` run only the given language, can be given multiple times for multiple languages
*  `-s/--shards` run with the given number of shards (defaults to 1)
*  `-v/--verbose` display all test output as it is running

There are more options that are documented with the `-h/--help` command line option.
