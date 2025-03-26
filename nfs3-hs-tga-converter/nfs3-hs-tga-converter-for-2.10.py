#!/usr/bin/env python

from gimpfu import *

# main variable definition
def nfs3_hs_tga_converter(inputFile, convType, flipToggle, editToggle, tgaOrigin):
    # opens image, transfers alpha channel to a mask and selects it
    inputImage = pdb.file_tga_load(inputFile, inputFile)
    imageLayer = pdb.gimp_image_get_active_layer(inputImage)
    imageMask = pdb.gimp_layer_create_mask(imageLayer, 3)
    pdb.gimp_layer_add_mask(imageLayer, imageMask)
    pdb.gimp_layer_set_edit_mask(imageLayer, TRUE)
    pdb.gimp_context_set_sample_criterion(6)
    
    # this block runs if conversion type is set to "NFS3 > HS", selecting by colors and painting the selection with the new ones
    if convType == 0:
        pdb.gimp_context_set_sample_threshold_int(5)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (165,165,165))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((241,241,241))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (208,208,208))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((165,165,165))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (229,229,229))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((165,165,165))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_selection_clear(inputImage)

        # flips the image vertically if the "Flip texture vertically" check is enabled
        if flipToggle == 1:
            pdb.gimp_image_flip(inputImage, 1)
            
        # exports the image to CAR00_NFSHS.tga if the if the "Keep open for editing, don't save" option is disabled
        if editToggle == 0:
            finalLayer = pdb.gimp_image_merge_visible_layers(inputImage, 0)
            outputFile = (inputFile[:-4]) + "_NFSHS" + (inputFile[-4:])
            pdb.file_tga_save(inputImage, finalLayer, outputFile, outputFile, 0, tgaOrigin)
            pdb.gimp_image_clean_all(inputImage)
        # displays image and keeps it if "Keep open for editing, don't save" option is enabled
        else:
            display = pdb.gimp_display_new(inputImage)
            
    # this block runs if conversion type is set to "NFSHS > HS", same as above
    if convType == 1:
        pdb.gimp_context_set_sample_threshold_int(2)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (99,99,99))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((255,255,255))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (165,165,165))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((229,229,229))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (208,208,208))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((128,128,128))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (241,241,241))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((168,168,168))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_image_select_color(inputImage, 2, imageMask, (128,128,128))
        if (pdb.gimp_selection_is_empty(inputImage) == 0):
            pdb.gimp_selection_sharpen(inputImage)
            pdb.gimp_context_set_foreground((255,255,255))
            pdb.gimp_edit_fill(imageMask, 0)
        pdb.gimp_selection_clear(inputImage)

        # flips the image vertically if the "Flip texture vertically" check is enabled
        if flipToggle == 1:
            pdb.gimp_image_flip(inputImage, 1)
        
        # exports the image to CAR00_NFS3.tga if the if the "Keep open for editing, don't save" option is disabled
        if editToggle == 0:
            finalLayer = pdb.gimp_image_merge_visible_layers(inputImage, 0)
            outputFile = (inputFile[:-4]) + "_NFS3" + (inputFile[-4:])
            pdb.file_tga_save(inputImage, finalLayer, outputFile, outputFile, 0, tgaOrigin)
            pdb.gimp_image_clean_all(inputImage)
            
        # displays image and keeps it if "Keep open for editing, don't save" option is enabled
        else:
            display = pdb.gimp_display_new(inputImage)


register(
    "python-fu-nfs3-hs-tga-converter", # register name
    "Converts TGA files between NFS3 and NFSHS-spec", # short description
    "Converts TGA files between NFS3 and NFSHS-spec", # full description
    "AJ_Lethal", "AJ_Lethal", "2022", # author info (name, copyright, date)
    "NFS3/HS TGA Converter", # name in menus
    "", # image type this plug-in works in (*, RGB, RGB*, RGBA, GRAY etc...)
    [
        (PF_FILE, "inputFile", "Input TGA file: ", 0),
        (PF_OPTION, "convType", "Conversion type: ", 0,
             (
                 ["NFS3 > HS", "NFSHS > NFS3"]
              )
         ),
        (PF_TOGGLE, "flipToggle", "Flip texture vertically",1),        
        (PF_TOGGLE, "editToggle", "Keep open for editing, don't save",0),
        (PF_OPTION, "tgaOrigin", "Exported TGA origin: ", 0,
             (
                 ["Bottom left (NFSHS default)", "Top left (NFS3 default)"]
              )
         )
    ],
    [],
    nfs3_hs_tga_converter, menu="<Image>/File/File Operations")
main()
