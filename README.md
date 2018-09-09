# pocketsphinx-demo
Talk: Demo to explain how to do TTS w/ python, pocketsphinx and Gstreamer.

## Requirements ( OSX )
- Homebrew
- https://github.com/bossjones/homebrew-scarlett-deps
- Gstreamer
- PyGobject
- GLib
- GTK
- Cmusphinxbase
- Pocketsphinx
- Python 3.7.0 ( Version we tested on )

## Setup your development environment ( OSX )

### Gstreamer, Python, GTK, GLib ... GNOME Development suite!

Start off by tapping the custom homebrew packages that installs pocketsphinx python and gstreamer bindings

```
$ brew tap bossjones/scarlett-deps
```

Install GLib, Gstreamer, and other dependencies required to use the whole Gnome development suite:

```
brew install glib cairo gobject-introspection graphite2 graphviz gsettings-desktop-schemas gspell gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly gst-python gst-validate gstreamer gtk+ gtk+3 gtk-mac-integration gtksourceview3 harfbuzz py3cairo pygobject pygobject3 pygtk portaudio pulseaudio
```

Install sphinxbase and pocketsphinx:

```
brew install --verbose --with-python scarlett-deps/cmu-sphinxbase

# ----------------------------
# (IF ABOVE DOESN'T WORK ) In some older versions of osx we've needed to set the version xcode inorder for autotools to find the correct version of openal development headers.

# Run `xcodebuild -showsdks` and find the value under "macOS SDKs", should look something like this: "-sdk macosx10.12", then set that value to environment variable TRAVIS_XCODE_SDK.

# Now Install sphinxbase
env TRAVIS_XCODE_SDK="-sdk macosx10.12" brew install --verbose --with-python --devel scarlett-deps/cmu-sphinxbase

# ----------------------------

# Now Install pocketsphinx
brew install --verbose --with-python scarlett-deps/cmu-pocketsphinx

# Set the libary path so that python, gstreamer, and pocketsphinx can find each other

source ./contrib/hacking/jarvis-env
```

### Setup: Python Virtual Environment

I swear by this guide right here on how to install python and run multiple versions at the same time. [The definitive guide to setup my Python workspace](https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14)

```
# Install the pyenv managed version of python 3.7.0 on your system. This will remain even when brew update the version of python later on.

env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.0

# Create a virtual environment against python 3.7.0
pyenv virtualenv --system-site-packages 3.7.0 pocketsphinx-demo

# Step into your virtual environment
pyenv activate pocketsphinx-demo

# Install all of your python module dependcies in your virtual environment
make install-virtualenv-osx

# Test that everything works!
make check
```

# Update your corpus so that pocketsphinx can recognize more words!

`vim ./speech/corpus/demo-corpus.txt`

Add words that you want pocketsphinx to try to recognize. For the purpose of the demo we have:

```
IRON MAN
JARVIS
HELLO
THANK YOU
```

Now update the language model and dictonary by using the lmtool-cli script commited to this repo.

```
make update-corpus
```

This script does a POST request to `http://www.speech.cs.cmu.edu/tools/lmtool-new.html` using the data in `demo-corpus.txt`, then downloads the newly generated `.dic` and `.lm` files into the `lang` folder.

Now you're ready to run the demo!

# Run live demo!

`make run-livedemo`

Screen Should look like this:
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Screenshot of livedemo")


# Language Models

https://sourceforge.net/projects/cmusphinx/files/Acoustic%20and%20Language%20Models/


# References

### Pocketsphinx @ CMU
- [CMUSphinx Tutorial For Developers](https://cmusphinx.github.io/wiki/tutorial/)
- http://www.speech.cs.cmu.edu/cgi-bin/cmudict#phones
- [ About the CMU dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict#about)
- [Speech at CMU](http://www.speech.cs.cmu.edu/)

### Gnome Desktop Environment
- [pygobject developer documentation](https://lazka.github.io/pgi-docs/)
- [GStreamer documentation](https://gstreamer.freedesktop.org/documentation/)
- [GLib Reference Manual](https://developer.gnome.org/glib/)
- [GTK+ 3 Reference Manual](https://developer.gnome.org/gtk3/stable/)


# Important terms in speech recognition

`confidence`: The probability that the result returned by the speech engine matches what a speaker said. Speech engines generally return confidence scores that reflect the probability; the higher the score, the more likely the engine's result is correct.

`dictionary`: A large set of data used by a speech engine while doing speech recognition that defines the phonemes in a language or dialect.

`directed dialogue`: An approach to speech application design that prompts users to say specific phrases. Contrast with natural language.

`grammar`: A file that contains a list of words and phrases to be recognized by a speech application. Grammars may also contain bits of programming logic to aid the application. All of the active grammar words make up the vocabulary. See also ABNF, SRGS, and grXML.

`natural langauge`: An approach to speech application design that encourages users to speak naturally to the system. Contrast with directed dialogue.

`phoneme`: The basic unit of sound. In the same way that written words are composed of letters, a spoken word is composed of various phonemes, though they may not line up precisely. For instance, the English word "food" has three phonemes (the "f" sound, the "oo" sound, and the "d" sound) but four letters. A speech engine uses its dictionary to break up vocabulary words and utterances into phonemes, and compares them to one another to perform speech recognition.

`utterance`: Spoken input from the user of a speech application. An utterance may be a single word, an entire phrase, a sentence, or even several sentences.

`vocabulary`: The total list of words the speech engine will be comparing an utterance against. The vocabulary is made up of all the words in all active grammars.

`voice recognition`: A form of biometrics that identifies users by recognizing their unique voices. Though it is often used interchangeably with speech recognition, the two are different. Voice recognition is concerned with recognizing voices, while speech recognition is concerned with recognizing the content of speech.
