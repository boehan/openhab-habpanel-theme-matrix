# openhab-habpanel-theme-matrix
A custom theme for OpenHab HabPanel

<h1>Prerequisites</h1>

* Installed OpenHab 2.1
* Installed UI HabPanel 2.1

<h1>Assumptions</h1>

<h2>Environment</h2>

In  my setup I'm running on a Raspberry Pi 3, the folder structure is:

* domain name & port = openhabianpi.local:8080
* openhab root = /etc/openhab2/
* openhab html = /etc/openhab2/html
* theme folder = /etc/openhab2/html/matrix-theme (create this folder)

You may need to adjust your folder structure according to your environment.

<h2>Icons</h2>

All icons used in the theme are in SVG format.

There are three sets of icons used in this theme:

* AppIcons.svg = App Icons to display logos for Netflix, Spotify, Apple TV, etc. in the TV and Music widget. I created those SVGs and included the file AppIcons.svg in the repository.
* matrixicons.svg = A small number of default icons (on, off, none, etc.) are included in the file matrixicons.svg.
* material-icons.svg = All other icons are gathered from https://materialdesignicons.com/ and are not included in the repository. If you want to add moree icons, download the the individual [SVG-Files](https://github.com/Templarian/MaterialDesign-SVG) yourself and follow the instructions here to use them. You will need to combine the svg files of the icons you like into a single file called "material-icons.svg".

*SVG Symbols and Styling*

The theme uses CSS to set the color of the icons (explained here: https://css-tricks.com/almanac/properties/f/fill/).

It also uses a technique to combine different icons into a single SVG file. This allows for faster loading and better organization of the icons. Within HTML, the icons are then accessed using the "use" tag and specifying the file and symbol id as such:

```html
<svg viewBox="0 0 48 48"><use xlink:href="/static/matrix-theme/matrixicons.svg#off"></use></svg>
```

*Use of materialdesignicons*

1. Download the icons here https://github.com/Templarian/MaterialDesign-SVG
2. Since there are 3000+ icons in the package you don't want to load them all in HABPanel
3. Find the icons you want to use and copy them to a separate folder (e.g. material-icons/used/)
4. We will use the Node.js based tools [SVGO](https://github.com/svg/svgo) (to remove unnecessary attributes of the single svg-files) and [SVG-Join](https://github.com/Climenty/svg-join) (to merge them to a single svg-file). Install them with the following commands ([Node.js and npm required](https://nodejs.org/en/)):
```
$ [sudo] npm install -g svgo
$ [sudo] npm install -g svg-join
```
5. Optimize the icon SVGs you want to use (assuming they are gathered in material-icons/used/):

```
svgo material-icons/used/ --disable=removeViewBox
```

6. Merge the optimized SVGs to a single `material-icons.svg` file:

```
svg-join -s "material-icons/used/*.svg" -o "/etc/openhab2/html/matrix-theme/" -n material-icons
```
NOTE: This does also generate a separate `material-icons.css`file which will not be used and can be ignored or deleted.

You can rerun the script as often as you want when you want to add/remove icons from the file.

<h1>Installation</h1>

1. Add Files to your OpenHab installation

Create a sub folder called "matrix-theme" in your /etc/openhab2/html folder.

Copy the follwing files from the repository to your openhab installation into the folder "html/matrix-theme":

Filename | Description
-------- | -----------
AppIcons.svg | Icons for App Logos (Netflix, Apple TV, Spotify, etc.)
matrixicons.svg | Basic Icons for On/Off/None, etc.
material-icons.svg | Merged materialdesignicons
matrix-theme.css | CSS file with theme
Roboto-Light.ttf | Roboto Font Light (Google Font)
Roboto-Regular.ttf | Roboto Font Regular (Google Font)
Roboto-Thin.ttf | Roboto Font Thin (Google Font)

2. Select Theme

Open HabPanel, goto settings and set the setting "Additional Stylesheet (optional)" to:

```
/static/matrix-theme/matrix-theme.css
```

3. Create or Go to a dashboard in HabPanel

4. Click Edit, then Add Widget

5. Click the Cog-Wheel to add a Custom Widget

6. Import the Custom Widgets from the repository and add them:

Original widgets (./widgets/original) by [pmpkk](https://github.com/pmpkk/openhab-habpanel-theme-matrix)
* System Widget.widget.json
* Outdoor Widget.widget.json
* Cars Widget.widget.json
* Ground Floor Widget.widget.json
* Home Widget.widget.json

Additional, MaterialDesign-based, widgets (./widgets/new)
* Home.widget.json
* Heating.widget.json
* Ventilation.widget.json
* Weather & Astro.widget.json
* Lighting.widget.json
* Entertainment.widget.json

7. Go back to Dashboard, click Add Widgets and chose the widget you just imported.

Note, the design doesn't support the gridster layout of HabPanel. It overrides it. You need to make the widget the width of the page and select both options "Don't Wrap in Container" and "No Background" in the widget config.
