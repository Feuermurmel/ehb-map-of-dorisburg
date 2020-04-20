# Map of Dorisburg

This project aims to create a map of Dorisburg from the Game [Else Heart.Break()](http://elseheartbreak.com) as an Inkscape SVG file. A PDF of the current version can be downloaded from the [releases](https://github.com/Feuermurmel/ehb-map-of-dorisburg/releases) page.

This map is intended to given an overview of the "overworld" of Else Heart.Break() and includes the shoreline, the tram's route, buildings, and other large stuff on the ground which is useful for navigation. The map tries to mostly keep relative sizes and positions true to the level geometry, where possible (the world of Else Heart.Break() is not euclidean in some places).

Currently, the following elements are present or intended to be present on the map:

 - The shape shoreline and islands.
 - The tram route and including stations.
 - Boundaries where the player switches from one level file to the next.
 - Buildings and the two ships.
 - Large stuff on the ground level like walls, fences, crates, and containers.
 - Some berths and platforms and other walkable areas separate from the ground.

I'm not intending to include smaller stuff or interactable things like computers or fuse boxes or stuff that can be picked up. Maybe I will include doors the player can open. The map is intended to help the player navigate, not tell him where stuff is.


## Exporting to PDF

The map can be exported using Inkscape to a PDF file named `map.pdf` by running `./render-pdf.sh`. The way I used swatches to color all the elements of the map sometimes leads Inkscape to place invalid transformation matrices in gradient definitions. When this happens, the following warning will be printed while exporting and part of the map will be missing from the PDF file:

```
** (inkscape:71446): CRITICAL **: 11:31:47.677: error while rendering output: invalid matrix (not invertible)
```

Currently, the only way I know is to manually go through all calls to `matrix()` in `map.svg` and fix singular matrices. They are easy to spot as they are usually the ones with a lot of 0 elements.


## Renderings of level geometry

The map is based on the 3D models of the levels extracted from the game files. Low-resolution renderings of those levels can be found in the directory `renderings` and are included in a separate layer in the Inkscape SVG file. The 3D models were extracted using the [Unity Assets Bundle Extractor](https://github.com/DerPopo/UABE) (UAEB) and then rendered to PNG files using the script in [ehb-collada-render](https://github.com/Feuermurmel/ehb-collada-render).

UAEB can be used to extract the level geometry of each level as a COLLADA .dae file. Some levels are split into multiple meshes, so ehb-collada-render has the ability to process multiple files and combine them while rendering. This works by organizing all the geometries into separate directories and the passing each directory to the `collada-render` command:

```
$ find meshes -name '*.dae'
meshes/level0/Combined Mesh (root_ scene)-level0-1.dae
meshes/level1/Combined Mesh (root_ scene) 2-level1-2.dae
meshes/level1/Combined Mesh (root_ scene)-level1-1.dae
$ collada-render meshes/level0
Rendering renderings/level0.png ...
[...]
```

Only some level files are currently used for the map, rendering just those parallelized is easy:

```
parallel -u collada-render ::: meshes/level{1,10,105,126,132,143,153,154,2,22,23,24,25,26,30,4,56,68,88,89,95}
```
