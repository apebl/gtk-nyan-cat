#!/usr/bin/env python3
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

class NyanCatWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Nyan Cat Demo")
        self.set_border_width(16)
        self.connect("destroy", Gtk.main_quit)
        self.resize(500, 300)

        hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        self.add(hbox)

        self.hprogress = Gtk.ProgressBar()
        self.hprogress.set_pulse_step(0.01)
        self.hprogress.set_valign(Gtk.Align.CENTER);
        hbox.pack_start(self.hprogress, True, True, 0)

        self.vprogress = Gtk.ProgressBar(orientation=Gtk.Orientation.VERTICAL)
        self.vprogress.set_pulse_step(0.01)
        self.vprogress.set_halign(Gtk.Align.CENTER)
        hbox.pack_start(self.vprogress, True, True, 0)

        spinner = Gtk.Spinner()
        spinner.start()
        hbox.pack_start(spinner, True, True, 0)

        spinner = Gtk.Spinner()
        spinner.start()
        spinner.set_sensitive(False)
        hbox.pack_start(spinner, True, True, 0)

        spinner = Gtk.Spinner()
        hbox.pack_start(spinner, True, True, 0)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        vbox.set_halign(Gtk.Align.CENTER)
        hbox.pack_start(vbox, True, True, 0)

        button = Gtk.CheckButton(label="Activity mode")
        button.connect("toggled", self.on_activity_mode_toggled)
        vbox.pack_start(button, True, True, 0)

        button = Gtk.CheckButton(label="Right to Left")
        button.connect("toggled", self.on_right_to_left_toggled)
        vbox.pack_start(button, True, True, 0)

        self.activity_mode = False
        self.timeout_id = GLib.timeout_add(10, self.on_timeout)

    def on_activity_mode_toggled(self, button):
        self.activity_mode = button.get_active()
        if self.activity_mode:
            self.hprogress.pulse()
            self.vprogress.pulse()
        else:
            self.hprogress.set_fraction(0.0)
            self.vprogress.set_fraction(0.0)

    def on_right_to_left_toggled(self, button):
        value = button.get_active()
        self.hprogress.set_inverted(value)
        self.vprogress.set_inverted(value)

    def on_timeout(self):
        if self.activity_mode:
            self.hprogress.pulse()
            self.vprogress.pulse()
        else:
            new_value = self.hprogress.get_fraction() + 0.001
            if new_value > 1:
                new_value = 0
            self.hprogress.set_fraction(new_value)
            self.vprogress.set_fraction(new_value)
        return True

win = NyanCatWindow()
win.show_all()
Gtk.main()
