const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#fefcfb", /* black   */
  [1] = "#7C91C3", /* red     */
  [2] = "#8F9AAC", /* green   */
  [3] = "#979DA5", /* yellow  */
  [4] = "#94A8B4", /* blue    */
  [5] = "#D2BDB5", /* magenta */
  [6] = "#8597C6", /* cyan    */
  [7] = "#383B44", /* white   */

  /* 8 bright colors */
  [8]  = "#978e8b",  /* black   */
  [9]  = "#7C91C3",  /* red     */
  [10] = "#8F9AAC", /* green   */
  [11] = "#979DA5", /* yellow  */
  [12] = "#94A8B4", /* blue    */
  [13] = "#D2BDB5", /* magenta */
  [14] = "#8597C6", /* cyan    */
  [15] = "#383B44", /* white   */

  /* special colors */
  [256] = "#fefcfb", /* background */
  [257] = "#383B44", /* foreground */
  [258] = "#383B44",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
