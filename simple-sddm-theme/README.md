simple sddm theme
==================

A very simple theme without any fuss, shutdown and reboot buttons with an input, the input doesn't have any borders or anything, you just type in the password and enter.

![sample](https://github.com/mdibaiee/simple-sddm-theme/blob/master/screenshot.png?raw=true)

If you want to integrate this with `nitrogen` to get your login background to sync with your desktop background, put this script in your `/usr/share/sddm/scripts/Xsetup`:

```bash
rm /usr/share/sddm/themes/mahdi/background-link
cp $(cat /home/mahdi/.config/nitrogen/bg-saved.cfg | head -n 2 | tail -n 1 | sed 's/file=//') /usr/share/sddm/themes/mahdi/background-link
```

If you want to change the background, change the `background-link` to something else using:

```bash
sudo ln your-desired-background.jpg /usr/share/sddm/themes/mahdi/background-link
```
