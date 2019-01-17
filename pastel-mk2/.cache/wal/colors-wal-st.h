const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#fefbfd", /* black   */
  [1] = "#D2A7B8", /* red     */
  [2] = "#B6A4D2", /* green   */
  [3] = "#E7D0B6", /* yellow  */
  [4] = "#D3B2CB", /* blue    */
  [5] = "#CCADD7", /* magenta */
  [6] = "#ECB8CD", /* cyan    */
  [7] = "#755891", /* white   */

  /* 8 bright colors */
  [8]  = "#968c94",  /* black   */
  [9]  = "#D2A7B8",  /* red     */
  [10] = "#B6A4D2", /* green   */
  [11] = "#E7D0B6", /* yellow  */
  [12] = "#D3B2CB", /* blue    */
  [13] = "#CCADD7", /* magenta */
  [14] = "#ECB8CD", /* cyan    */
  [15] = "#755891", /* white   */

  /* special colors */
  [256] = "#fefbfd", /* background */
  [257] = "#755891", /* foreground */
  [258] = "#755891",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
