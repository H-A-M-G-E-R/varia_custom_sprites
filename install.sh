#!/bin/bash
# create symlinks for web2py

# remove symlinks in web2py install first, for first time use
CLEAN=1
if [ "${1}" == "--clean" ]; then
    CLEAN=0
fi

# we are in ~/RandomMetroidSolver/varia_custom_sprites/ as a submodule
CUR=$(dirname $0)/..
cd ${CUR}
CUR=$(pwd)

CUSTOM_SPRITES=$(python3 -c "from varia_custom_sprites.custom_sprites import customSprites; print(' '.join(list(customSprites.keys())))")

THUMBNAILS_DIR=~/web2py/applications/solver/static/images
SHEETS_DIR=~/web2py/applications/solver/static/images/sprite_sheets

if [ ${CLEAN} -eq 0 ]; then
    echo "Clean existing web2py symlinks"
    for SPRITE in ${CUSTOMSPRITES}; do
        rm -f ${THUMBNAILS_DIR}/${SPRITE}.png
        rm -f ${SHEETS_DIR}/${SPRITE}.png
    done
fi

# add ln for thumbnails & sprite sheets in web2py
echo "Create web2py symlinks"
for SPRITE in ${CUSTOM_SPRITES}; do
    [ -L ${THUMBNAILS_DIR}/${SPRITE}.png ] || ln -s ${CUR}/samus_sprites/${SPRITE}.png ${THUMBNAILS_DIR}/${SPRITE}.png
    [ -L ${SHEETS_DIR}/${SPRITE}.png ] || ln -s ${CUR}/sprite_sheets/${SPRITE}.png ${SHEETS_DIR}/${SPRITE}.png
done

echo "done"
