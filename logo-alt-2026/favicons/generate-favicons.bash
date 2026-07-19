#!/bin/sh

# Erzeugung 
#

rm -v favicon*

# convert jugbb-favicon-280x280-master.png -resize 32x32 favicon-32x32.png
in=jugbb-favicon-280x280-master.png

echo "<!-- Start: Links for the Favicons -->" > header-snippet.html

while read line
do
    x=$(echo ${line} | cut -d ',' -f 1)
    y=$(echo ${line} | cut -d ',' -f 2)
    t=$(echo ${line} | cut -d ',' -f 3)

    echo "$in => ${x}x${y}"

    case ${t} in
	apple)
	    convert $in -resize ${x}x${y} apple-touch-icon-${x}x${y}.png
	    echo "<link rel=\"apple-touch-icon\" sizes=\"${x}x${y}\" href=\"/apple-touch-icon-${x}x${y}.png\" />" >> header-snippet.html
	    ;;
    esac

    # Sicher ist sicher
    
    convert $in -resize ${x}x${y} favicon-${x}x${y}.png
    echo "<link rel=\"icon\" sizes="${x}x${y}" href=\"/favicon-${x}x${y}\"  />" >> header-snippet.html

    
done <<EOF
16,16
32,32
48,48
75,75
96,96
120,120,apple
128,128
144,144
152,152,apple
167,167,apple
180,180,apple
195,195
196,196
228,228
EOF

#-- Erzeugung von favicon.ico

convert favicon-16x16.png favicon-32x32.png favicon-48x48.png favicon.ico

echo "<!-- End: Links for the Favicons -->" >> header-snippet.html

exit
#-- Quellen und Tooling
* https://github.com/audreyr/favicon-cheat-sheet
* https://www.emergeinteractive.com/insights/detail/The-Essentials-of-FavIcons-in-2017
* https://realfavicongenerator.net/favicon_checker
* https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon/
* https://developer.apple.com/library/archive/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html
