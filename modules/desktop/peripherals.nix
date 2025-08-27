{pkgs, ...}: {
  #============================= Audio(PipeWire) =======================

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pulseaudio # provides `pactl`, which is required by some apps(e.g. sonic-pi)
  ];

  # PipeWire is a new low-level multimedia framework.
  # It aims to offer capture and playback for both audio and video with minimal latency.
  # It support for PulseAudio-, JACK-, ALSA- and GStreamer-based applications.
  # PipeWire has a great bluetooth support, it can be a good alternative to PulseAudio.
  #     https://nixos.wiki/wiki/PipeWire
  services.pipewire = {
    enable = true;
    # package = pkgs-unstable.pipewire;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    wireplumber.enable = true;
  };
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  # sound.enable = false;
  # Disable pulseaudio, it conflicts with pipewire too.
  services.pulseaudio.enable = false;

  #============================= Bluetooth =============================

  # enable bluetooth & gui paring tools - blueman
  # or you can use cli:
  # $ bluetoothctl
  # [bluetooth] # power on
  # [bluetooth] # agent on
  # [bluetooth] # default-agent
  # [bluetooth] # scan on
  # ...put device in pairing mode and wait [hex-address] to appear here...
  # [bluetooth] # pair [hex-address]
  # [bluetooth] # connect [hex-address]
  # Bluetooth devices automatically connect with bluetoothctl as well:
  # [bluetooth] # trust [hex-address]
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  #================================= Misc =================================

  services = {
    printing.enable = true; # Enable CUPS to print documents.
    geoclue2.enable = true; # Enable geolocation services.

    udev = {
      packages = with pkgs; [
        # gnome.gnome-settings-daemon
        gnome-settings-daemon
        platformio # udev rules for platformio
        openocd # required by paltformio, see https://github.com/NixOS/nixpkgs/issues/224895
        android-udev-rules # required by adb
        openfpgaloader
        dolphin-emu
      ];
      # extraRules = ''
      #   # gamecube wii u usb adapter
      #   SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
      # '';
    };

    # A key remapping daemon for linux.
    # https://github.com/rvaiya/keyd
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              # overloads the capslock key to function as both escape (when tapped) and control (when held)
              # capslock = "overload(control, esc)";
              # esc = "capslock";
            };
          };
          # extraConfig = "[control+shift]\nh = left\n";
          extraConfig = "
# Main configuration
[main]

# Solution for held Ctrl key
# leftcontrol = layer(tower_stack)  # Create dedicated control layer
# https://medium.com/@ethanppl/how-i-use-keyd-to-remap-my-keyboard-in-ubuntu-22-04-with-wayland-040519b8a3d6
# https://raw.githubusercontent.com/rvaiya/keyd/refs/heads/master/docs/keyd.scdoc

capslock = overload(tower_stack, esc)  # Create dedicated control layer

z = overload(z, z)

# Shift layer
[shift:S]

## shift+capslock is capslock
capslock = capslock

[tower_stack]
1 = macro(1+space)
2 = macro(2+space)
3 = macro(3+space)
4 = macro(4+space)
5 = macro(5+space)
6 = macro(6+space)
7 = macro(7+space)
8 = macro(8+space)
9 = macro(9+space)
0 = macro(0+space)
#k = playpause
k = mute

# Custom z layer
[z]

## Escape common patterns
i = macro(zi)
o = macro(zo)

## Emails
e = macro(example@mail.com)
g = macro(example@mail.com)

## Simplify complicated shortcut keys
v = C-S-v
n = C-S-a
x = A-f4
s = command(systemctl suspend)

## Arrows
j = down
k = up
h = left
l = right

## Media / modifier
m = oneshot(media)

[media]

# TODO: Media buttons do not work :(
j = previoussong
k = playpause
l = nextsong

a = macro({ enter 10ms \"Aut 10ms hor 10ms iza 10ms tio 10ms n\": space \"Bea 10ms rer space C-v) ";
        };
      };
    };
  };
}
