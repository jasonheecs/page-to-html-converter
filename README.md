# Web Page to HTML Content Converter

[![Build Status][travis-badge]][travis-link] [![Coverage Status][coveralls-badge]][coveralls-link]

This app will scrape a url and return the page's HTML source, but without the HTML presentation attributes (`style`, `width`, `height`, etc.)

App is hosted at [https://page-to-html.herokuapp.com/](https://page-to-html.herokuapp.com/)

![example](https://i.imgur.com/GMlpuR6.gif "Example")

## Prerequisites
- Docker >= 18.01
- npm >= 5.3.0
- webpack >= 3.1.0
- Ruby >= 2.5.1
- [Bundler gem](https://bundler.io/)
- [overcommit gem >= 0.46.0](https://github.com/brigade/overcommit)

## Installation
```bash
git clone https://github.com/jasonheecs/page-to-html-converter.git .
cd page-to-html-converter
make build && make start
```

## Testing
Testing consists of [various linting tools](.overcommit.yml) and [Rspec tests](./app/spec).

To run tests, make sure you are in the project root and run:
```bash
make test
```

## License
MIT

[coveralls-badge]: https://coveralls.io/repos/github/jasonheecs/page-to-html-converter/badge.svg?branch=master
[coveralls-link]: https://coveralls.io/github/jasonheecs/page-to-html-converter?branch=master
[travis-badge]: https://travis-ci.com/jasonheecs/page-to-html-converter.svg?branch=master
[travis-link]: https://travis-ci.com/jasonheecs/page-to-html-converter
