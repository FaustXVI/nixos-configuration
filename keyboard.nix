{ config, pkgs, ... }:

{
	services = {
		xserver =  {
			layout = "fr";
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
					Identifier      "ErgoDox"
                                        MatchUSBID      "feed:1307"
					Driver          "evdev"
					Option          "XkbLayout"     "fr"
					Option          "XkbVariant"    "bepo"
					''
			];
		};
	};
}
