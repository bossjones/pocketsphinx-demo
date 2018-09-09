#!/usr/bin/env python

import gi

gi.require_version("GLib", "2.0")
gi.require_version("Gtk", "3.0")
gi.require_version('Gst', '1.0')
from gi.repository import GObject
from gi.repository import Gst
from gi.repository import Gtk
GObject.threads_init()
Gst.init(None)

gst = Gst

print("If you don't see any stacktraces, your environment is setup and good to go!!!")
