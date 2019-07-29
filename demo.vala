#!/usr/bin/vala --pkg=gtk+-3.0
using Gtk;

class NyanCatWindow : Window {
	private bool activity_mode = false;
	private uint timeout_id;
	private ProgressBar hprogress;
	private ProgressBar vprogress;

	public NyanCatWindow () {
		title = "Nyan Cat Demo";
		border_width = 16;
		destroy.connect(Gtk.main_quit);

		var hbox = new Box(Orientation.HORIZONTAL, 12);
		add(hbox);

		hprogress = new ProgressBar();
		hprogress.pulse_step = 0.01;
		hprogress.valign = Align.CENTER;
		hbox.pack_start(hprogress);

		vprogress = new ProgressBar();
		vprogress.orientation = Orientation.VERTICAL;
		vprogress.pulse_step = 0.01;
		vprogress.halign = Align.CENTER;
		hbox.pack_start(vprogress);

		var spinner = new Spinner();
		spinner.start();
		hbox.pack_start(spinner);

		spinner = new Spinner();
		spinner.start();
		spinner.sensitive = false;
		hbox.pack_start(spinner);

		spinner = new Spinner();
		hbox.pack_start(spinner);

		var vbox = new Box(Orientation.VERTICAL, 6);
		vbox.halign = Align.CENTER;
		hbox.pack_start(vbox);

		var button = new CheckButton.with_label("Activity mode");
		button.toggled.connect(on_activity_mode_toggled);
		vbox.pack_start(button);

		button = new CheckButton.with_label("Right to Left");
		button.toggled.connect(on_right_to_left_toggled);
		vbox.pack_start(button);

		timeout_id = Timeout.add(10, on_timeout);
	}

	private void on_activity_mode_toggled (ToggleButton button) {
		activity_mode = button.active;
		if (activity_mode) {
			hprogress.pulse();
			vprogress.pulse();
		} else {
			hprogress.fraction = 0;
			vprogress.fraction = 0;
		}
	}

	private void on_right_to_left_toggled (ToggleButton button) {
		hprogress.set_inverted(button.active);
		vprogress.set_inverted(button.active);
	}

	private bool on_timeout () {
		if (activity_mode) {
			hprogress.pulse();
			vprogress.pulse();
		} else {
			double newval = hprogress.fraction + 0.001;
			if (newval > 1) newval = 0;
			hprogress.set_fraction(newval);
			vprogress.set_fraction(newval);
		}
		return true;
	}
}

void main (string[] args) {
	Gtk.init (ref args);
	var win = new NyanCatWindow();
	win.show_all();
	Gtk.main();
}
