# Gem Name

Allows you to deploy apps hosted on Scalarium from the command line.

## How To Install

    sudo gem install scalarium_cli

## Example

### Rails

Add `scalarium.yml` in your config folder. It should look something like:

    staging:
      email: test@test.com
      password: password
      slug: YYY

    production:
      email: test@test.com
      password: password
      slug: XXX

You will find the slug of the application inside the URL:

![slug](https://img.skitch.com/20101229-nygy9t86d85ea8gjw5133kxjbj.jpg)

Then from the Root directory, just run

    sca deploy staging

You have access to all Scalarium deployment commands

    sca [deploy|rollback|start|stop|restart|undeploy]

#### Other options

Run migrations

    sca deploy staging --migrate

Add a comment

    sca deploy staging --comment="This is an awesome deploy!"

### Non Rails

By default the CLI will look at `./config/scalarium.yml` for the config.

If you wish to specify a different config file just type:

    sca deploy staging --config="path/to/config.yml"

## Note on Patches/Pull Requests

* Fork the project.
* Create a feature branch
* Make your feature addition or bug fix.
* Add tests.
* Commit, do not mess with RakeFile, version, or history.
* Send me a pull request.

## Copyright

Copyright (c) 2010 Red Davis.

## License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.