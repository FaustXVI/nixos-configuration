{ config, pkgs, ... }:

{
	services = {
		xserver =  {
            autoRepeatDelay = 200;
			layout = "fr";
			xkbVariant = "oss";
			inputClassSections = [
					''
					Identifier      "TypeMatrix"
					MatchIsKeyboard "on"
					MatchVendor     "TypeMatrix.com"
					MatchProduct    "USB Keyboard"
					Driver          "evdev"
					Option          "XbkModel"      "tm2030USB"
					Option          "XkbLayout"     "fr"
					Option          "XkbVariant"    "bepo"
					''
					''
					Identifier      "Ergodox"
					MatchIsKeyboard "on"
					MatchUSBID	"feed:1307"
					Driver          "evdev"
					Option          "XkbLayout"     "fr"
					Option          "XkbVariant"    "bepo"
					''
			];
		};
	};
	sound.mediaKeys.enable = true;
}
