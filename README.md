# elm-gravatar-app

To view the demo, you can just open the demo.html file in your browser.
This is a compiled version of the `JavaMagAuthors.elm` app.
If you want to run it yourself continue reading to set up your environment. We also made an
[Ellie App](https://ellie-app.com/39Pw2m3BxTKa1) to directly start programming without any installations.

## Development

Make sure you install Elm: https://guide.elm-lang.org/install.html

You could either:
* run `elm reactor`, go to http://localhost:8000 and click on JavaMagAuthors, or
* install [elm-live](https://github.com/wking-io/elm-live): `npm install -g elm elm-live@next`.
After successful installation, run `elm-live src/JavaMagAuthors.elm --output=elm.js --open` in the root folder

## IntelliJ setup
Install IntelliJ Elm plugin: https://plugins.jetbrains.com/plugin/10268-elm

Install elm-format: `npm install -g elm-format`. Then install the plugin `File Watchers` for IntelliJ. After that:
- Open IntelliJ settings, and go to File Watchers under Tools
- Add a new watcher
- Select `Elm Language` as File type
- Add the path for the program, e.g. `/usr/local/bin/elm-format`
- Add arguments `--yes $FilePath$`
- At advanced options uncheck the option `Auto-save`

Now every time you save an Elm file, it will be automatically formatted.