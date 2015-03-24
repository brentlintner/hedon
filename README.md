## Hedon

[![npm version](https://badge.fury.io/js/hedon.svg)](http://badge.fury.io/js/hedon)

A declarative, natural language scripting engine for NodeJS/JavaScript applications.

Beware!

This is still `<1.0.0`, and is still a WIP.

It is currently a proof of concept project of someone who
has little or no experience in natural language processing,
but nonetheless wanted to start a (fun) project to do such.

If anything, this could be used to create project bootstraps.

### Example

Create a file called `test.txt`:

```
Create an Express application.

The Express application should host {public/} when started.

Now, run my express application.
```

Then run:

    mkdir public
    echo "hello world!" >> public/foo.txt
    hedon -f test.txt

You should be able to navigate to:

    http://localhost:3000/foo.txt

You can also create `run.txt`:

```
Run my express application, please!
```

And just run that to start your application.
