Getto
=======

Mix a non-enumerable ```get``` method into plain JavaScript Object instances that supports deeply nested paths.

At Good Eggs we write [mixins](https://github.com/goodeggs/model-mixin) for frameworks that have models with `get` accessors like Backbone and Mongoose. Getto
allows us to use those mixins with plain Object instances, for example, those returned Mongoose's `lean` query
modifier.

Usage
---------------

```
var getto = require('getto');

var obj = {
  foo: 'one',
  bar: {
    two: 3
  },
  baz: [{a: 1}, {b: 2}]
}

getto(obj);

obj.get('baz.0.a') === 1; # => true
```

Refer to the test suite for more detailed usage and behavior.

Contributing
-------------

```
$ git clone https://github.com/goodeggs/getto && cd getto
$ npm install
$ npm test
```
