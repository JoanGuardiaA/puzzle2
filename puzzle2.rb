require "gtk3"
require "thread"
require "ruby-nfc"
require_relative "Rfid"

class Window < Gtk::Window 
  def initialize
    super
    set_title("Scan_NFC")
    set_size_request(700, 350)
    set_border_width(15)
    set_window_position(:center)
    signal_connect("destroy") do
    Gtk.main_quit
    @thr.kill if @thr
    end

    @box = Gtk::Box.new(:vertical, 15)
    @label = Gtk::Label.new("Aproxima una tarjeta al lector")
    @button = Gtk::Button.new(:label => "Clear")

    @box.pack_start(@label, expand: true, fill: true, padding: 0)
    @box.pack_start(@button, expand: true, fill: true, padding: 0)

    @label.override_background_color(0, Gdk::RGBA.new(0, 0, 1, 1))
    @label.override_color(0, Gdk::RGBA.new(1, 1, 1, 1))

    @button.signal_connect("clicked") do
      @label.set_markup("Insertar tarjeta")
      @label.override_background_color(0, Gdk::RGBA.new(0, 0, 1, 1))
    end

    add(@box)
  end

  def llegit(uid)
    @label.set_markup("Uid: " + uid)
    @label.override_background_color(0, Gdk::RGBA.new(1, 0, 0, 1))
  end

  def rfid_ini
    @rfid = Rfid.new
    @thr = Thread.new do
      while true
        uid = @rfid.read_uid
        llegit(uid)
      end
    end
  end
end

finestra = Window.new
finestra.show_all
finestra.rfid_ini

Gtk.main
