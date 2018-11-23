#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/Xutil.h>
#include <stdio.h>
#include <stdlib.h>
#include <jpeglib.h>

int write_jpeg(XImage *img, const char* filename)
{
    FILE* outfile;
    unsigned long pixel;
    int x, y;
    char* buffer;
    struct jpeg_compress_struct cinfo;
    struct jpeg_error_mgr       jerr;
    JSAMPROW row_pointer;

    outfile = fopen(filename, "wb");
    if (!outfile) {
        fprintf(stderr, "Failed to open output file %s", filename);
        return 1;
    }

    /* collect separate RGB values to a buffer */
    buffer = malloc(sizeof(char)*3*img->width*img->height);
    for (y = 0; y < img->height; y++) {
        for (x = 0; x < img->width; x++) {
            pixel = XGetPixel(img,x,y);
            buffer[y*img->width*3+x*3+0] = (char)(pixel>>16);
            buffer[y*img->width*3+x*3+1] = (char)((pixel&0x00ff00)>>8);
            buffer[y*img->width*3+x*3+2] = (char)(pixel&0x0000ff);
        }
    }

    cinfo.err = jpeg_std_error(&jerr);
    jpeg_create_compress(&cinfo);
    jpeg_stdio_dest(&cinfo, outfile);

    cinfo.image_width = img->width;
    cinfo.image_height = img->height;
    cinfo.input_components = 3;
    cinfo.in_color_space = JCS_RGB;

    jpeg_set_defaults(&cinfo);
    jpeg_set_quality(&cinfo, 85, TRUE);
    jpeg_start_compress(&cinfo, TRUE);

    while (cinfo.next_scanline < cinfo.image_height) {
        row_pointer = (JSAMPROW) &buffer[cinfo.next_scanline
                      *(img->depth>>3)*img->width];
        jpeg_write_scanlines(&cinfo, &row_pointer, 1);
    }
    free(buffer);
    jpeg_finish_compress(&cinfo);
    fclose(outfile);

    return 0;
}

Pixmap GetRootPixmap(Display* display, Window *root)
{
    Pixmap currentRootPixmap;
    Atom act_type;
    int act_format;
    unsigned long nitems, bytes_after;
    unsigned char *data = NULL;
    Atom _XROOTPMAP_ID;

    _XROOTPMAP_ID = XInternAtom(display, "_XROOTPMAP_ID", False);

    if (XGetWindowProperty(display, *root, _XROOTPMAP_ID, 0, 1, False,
                XA_PIXMAP, &act_type, &act_format, &nitems, &bytes_after,
                &data) == Success) {

        if (data) {
            currentRootPixmap = *((Pixmap *) data);
            XFree(data);
        }
    }

    return currentRootPixmap;
}

int main(int argc, const char *argv[])
{
    int screen;
    Window root;
    Display* display;
    XWindowAttributes attrs;
    Pixmap bg;
    XImage* img;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s [filename]\n", argv[0]);
        return 1;
    }

    display = XOpenDisplay(getenv("DISPLAY"));

    if (display == NULL) {
        fprintf(stderr, "cannot connect to X server %s\n",
                getenv("DISPLAY") ? getenv("DISPLAY") : "(default)");
        return 1;
    }

    screen = DefaultScreen(display);

    root = RootWindow(display, DefaultScreen(display));
    XGetWindowAttributes(display, root, &attrs);

    bg = GetRootPixmap(display, &root);
    img = XGetImage(display, bg, 0, 0, attrs.width, attrs.height, ~0, ZPixmap);
    XFreePixmap(display, bg);

    if (!img) {
        fprintf(stderr, "Can't create ximage\n");
        return 1;
    }

    if (img->depth != 24) {
        fprintf(stderr, "Image depth is %d. Must be 24 bits.\n", img->depth);
        return 1;
    }

    if (write_jpeg(img, argv[1])) {
        printf("JPEG file successfully written to %s\n", argv[1]);
    }
    XDestroyImage(img);

    return 0;
}
