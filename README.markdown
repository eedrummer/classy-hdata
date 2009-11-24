Classy hData
------------

The following project is an implementation of the [hData Network Transport](http://www.projecthdata.org/documents.html) using [Sinatra](http://www.sinatrarb.com/) and [DataMapper](http://datamapper.org/).

Setup and Running
-----------------

This project uses [Bundler](http://github.com/wycats/bundler) to manage its dependencies. To setup run:

    sudo gem install bundler

Then you can grab the necessary gems to run the project by:

    gem bundle update

Finally you can run the application with:

    ruby run.rb

Point your browser to http://localhost:4567 to get started. For working with the hData Network Transport, I would recommend using the [Poster Firefox Add-on](https://addons.mozilla.org/en-US/firefox/addon/2691).

Other Documentation
-------------------

You can find a description of the process I went through to create this code on [my blog](http://gregorowicz.blogspot.com/2009/11/classy-hdata.html).

To Do
-----
1. Add a proper config.ru file
2. Implement metadata POSTing

License
-------

Copyright 2009 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
